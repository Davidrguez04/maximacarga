package com.maximacarga.controladores;

import java.io.IOException;
import java.io.InputStream;
import java.net.URISyntaxException;
import java.time.LocalDate;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.maximacarga.dtos.PedidoDto;
import com.maximacarga.dtos.UsuarioDto;
import com.maximacarga.servicios.PedidoServicio;
import com.maximacarga.servicios.UsuarioServicio;
import com.maximacarga.util.Utilidades;

import jakarta.servlet.http.HttpSession;

/**
 * Controlador web encargado de la gestión de usuarios.
 * Incluye registro, activación, modificación, listado,
 * eliminación, recuperación de contraseña y gestión de foto.
 */
@Controller
public class UsuarioControlador {
	
	private final UsuarioServicio usuarioServicio;
	private final PedidoServicio pedidoServicio;
	

	public UsuarioControlador(UsuarioServicio usuarioServicio,
            PedidoServicio pedidoServicio) {
this.usuarioServicio = usuarioServicio;
this.pedidoServicio = pedidoServicio;
}
	
	 /**
     * Registra un nuevo usuario.
     * Construye el DTO y lo envía a la API.
     */
	@PostMapping("/registrarUsuario")
	public String registrarUsuario(
	        @RequestParam("nombre") String nombre,
	        @RequestParam("apellido1") String apellido1,
	        @RequestParam("apellido2") String apellido2,
	        @RequestParam("fechaNac") LocalDate fechaNac,
	        @RequestParam("movil") String movil,
	        @RequestParam("email") String email,
	        @RequestParam("rol") String rol,
	        @RequestParam("password") String password,
	        HttpSession session) {
	    
	    System.out.println("➡️ Entrando a registrarUsuario");
	    

	    UsuarioDto usuarioNuevo = new UsuarioDto();
	    usuarioNuevo.setNombreUsuario(nombre);
	    usuarioNuevo.setApellidosUsuario(apellido1 + " " + apellido2);
	    usuarioNuevo.setFchNacUsu(fechaNac);
	    usuarioNuevo.setMovil(movil);
	    usuarioNuevo.setCorreoElectronico(email);
	    usuarioNuevo.setTipoUsuario(rol);
	    usuarioNuevo.setContrasena(Utilidades.encriptarContrasenia(password));

	    try {
	    	System.out.println("📤 Enviando usuario al servicio...");
	        usuarioServicio.enviarRegistroUsuario(usuarioNuevo, session);
	        System.out.println("✅ Usuario enviado correctamente");
	    } catch (Exception e) {
	    	
	        return "error"; // debería existir /WEB-INF/jsp/error.jsp
	    }

	    System.out.println("➡️ Redirigiendo a /index");
	    return "inicioUsuario";
	}

	 /**
     * Activa la cuenta del usuario mediante token.
     */
	@GetMapping("/activarCuenta")
	public String activarCuenta(@RequestParam("token") String token, Model model) {
	    try {
	        System.out.println("Activando cuenta con token: " + token);

	        boolean resultado = usuarioServicio.activarCuenta(token);

	        // ✅ PASA EL RESULTADO A LA VISTA
	        model.addAttribute("activado", resultado);
	        model.addAttribute("mensaje", resultado
	                ? "Cuenta activada correctamente."
	                : "El enlace puede haber expirado o ya fue usado. Solicita un reenvío.");

	        // ✅ Usa SIEMPRE la misma vista; la JSP ya decide qué mostrar
	        return "resultadoActivacion";

	    } catch (Exception e) {
	        System.out.println("Error al activar cuenta con token " + token + " -> " + e);
	        model.addAttribute("activado", false);
	        model.addAttribute("mensaje", "Se produjo un error al activar la cuenta.");
	        return "resultadoActivacion";
	    }
	}
	
	/**
     * Modifica los datos del usuario autenticado.
     * Permite actualizar datos básicos y cambiar contraseña.
     */
	@PostMapping("/modificarUsuario")
	public String modificarUsuario(@RequestParam("nombreUsuario") String nombreUsuario,
	                               @RequestParam("apellidosUsuario") String apellidosUsuario,
	                               @RequestParam("correoElectronico") String email,
	                               @RequestParam("movil") String telefono,
	                               @RequestParam(value = "fchNacUsu", required = false) String fchNacUsu,
	                               @RequestParam(value = "nuevaContrasenia", required = false) String nuevaContrasenia,
	                               @RequestParam(value = "repNuevaContrasenia", required = false) String repNuevaContrasenia,
	                               @RequestParam(value = "contraseniaActual", required = false) String contraseniaActual,
	                               HttpSession session,
	                               RedirectAttributes redirectAttributes) throws IOException, URISyntaxException {

	    try {
	        
	        UsuarioDto usuarioSesion = (UsuarioDto) session.getAttribute("usuario");
	        if (usuarioSesion == null) {
	            redirectAttributes.addFlashAttribute("error", "Debes iniciar sesión.");
	            return "redirect:/";
	        }

	        
	        UsuarioDto usuarioAModificar = usuarioSesion;

	       
	        if (usuarioAModificar.getIdUsuario() == null) {
	            usuarioAModificar.setIdUsuario(usuarioSesion.getIdUsuario());
	        }
	        if (usuarioAModificar.getIdUsuario() == null) {
	            // Si sigue siendo null, la API siempre se quejará → mensaje claro
	            redirectAttributes.addFlashAttribute("error", "El usuario en sesión no tiene ID. Revisa que el login guarde el ID en UsuarioDto.");
	            return "redirect:/usuarios/modificar";
	        }

	        // 3️⃣ Actualizar datos básicos
	        if (nombreUsuario != null && !nombreUsuario.trim().isEmpty()) {
	            usuarioAModificar.setNombreUsuario(nombreUsuario.trim());
	        }

	        if (apellidosUsuario != null && !apellidosUsuario.trim().isEmpty()) {
	            usuarioAModificar.setApellidosUsuario(apellidosUsuario.trim());
	        }

	        if (telefono != null && !telefono.trim().isEmpty()) {
	            usuarioAModificar.setMovil(telefono.trim());
	        }

	        if (email != null && !email.trim().isEmpty()) {
	            usuarioAModificar.setCorreoElectronico(email.trim());
	        }

	        if (fchNacUsu != null) {
	        	usuarioAModificar.setFchNacUsu(LocalDate.parse(fchNacUsu));
	        }

	        // 4️⃣ Cambio de contraseña (opcional)
	        if (nuevaContrasenia != null && !nuevaContrasenia.trim().isEmpty()) {

	            if (contraseniaActual == null || contraseniaActual.trim().isEmpty()) {
	                redirectAttributes.addFlashAttribute("error", "Debes introducir tu contraseña actual para cambiarla.");
	                return "redirect:/usuarios/modificar";
	            }

	            if (!nuevaContrasenia.equals(repNuevaContrasenia)) {
	                redirectAttributes.addFlashAttribute("error", "Las contraseñas no coinciden.");
	                return "redirect:/usuarios/modificar";
	            }

	            UsuarioDto usuarioCambioContrasenia = new UsuarioDto();
	            usuarioCambioContrasenia.setCorreoElectronico(usuarioAModificar.getCorreoElectronico());
	            usuarioCambioContrasenia.setContraseniaActual(contraseniaActual);
	            usuarioCambioContrasenia.setContrasena(nuevaContrasenia);

	            String respuestaCambioContrasenia = usuarioServicio.cambiarContrasenia(usuarioCambioContrasenia);

	            if (!"success".equals(respuestaCambioContrasenia)) {
	                redirectAttributes.addFlashAttribute("error", "Error al cambiar la contraseña.");
	                return "redirect:/usuarios/modificar";
	            }
	        }

	        // 5️⃣ Guardamos en la API (aquí ya va con ID)
	        String respuesta = usuarioServicio.actualizarUsuario(usuarioAModificar);

	        if (!"success".equals(respuesta)) {
	            redirectAttributes.addFlashAttribute("error", "Error al actualizar el usuario: " + respuesta);
	            return "redirect:/usuarios/modificar";
	        }

	        // 6️⃣ Refrescamos la sesión con los datos nuevos
	        session.setAttribute("usuario", usuarioAModificar);

	        redirectAttributes.addFlashAttribute("mensaje", "Usuario actualizado correctamente.");

	        // 7️⃣ Volvemos según el rol
	        return "admin".equalsIgnoreCase(usuarioAModificar.getTipoUsuario())
	                ? "admin"
	                : "usuario";

	    } catch (Exception e) {
	        e.printStackTrace();
	        redirectAttributes.addFlashAttribute("error", "Ocurrió un error inesperado al modificar el usuario.");
	        return "redirect:/usuarios/modificar";
	    }
	}

	/**
     * Modifica los usuarios muestra jsp.
     */
	@GetMapping("/usuarios/modificar")
	public String mostrarFormularioModificar(HttpSession session, Model model) {

	    UsuarioDto usuario = (UsuarioDto) session.getAttribute("usuario");

	    model.addAttribute("usuario", usuario);

	    return "modificarUsuario"; // JSP
	}
	
	/**
     * Lista todos los usuarios (solo admin).
     */
	@GetMapping("/usuarios/listar")
	public String listarUsuarios(Model model, HttpSession session) {

	    UsuarioDto usuarioSesion = (UsuarioDto) session.getAttribute("usuario");

	    // 🔐 Seguridad básica
	    if (usuarioSesion == null || !"admin".equalsIgnoreCase(usuarioSesion.getTipoUsuario())) {
	        return "redirect:/";
	    }

	    try {
	        model.addAttribute("usuarios", usuarioServicio.listarUsuarios());
	    } catch (Exception e) {
	        e.printStackTrace();
	        model.addAttribute("error", "No se pudieron cargar los usuarios");
	    }

	    return "listaUsuarios"; // JSP
	}
	

    /**
     * Elimina los usuarios desde admin por id.
     */
	@GetMapping("/usuarios/eliminar")
	public String eliminarUsuario(@RequestParam("id") Long id,
	                              HttpSession session,
	                              RedirectAttributes redirectAttributes) {

	    UsuarioDto usuarioSesion = (UsuarioDto) session.getAttribute("usuario");

	    // 1️⃣ Comprobar sesión
	    if (usuarioSesion == null) {
	        return "redirect:/";
	    }

	    // 2️⃣ Solo admins pueden eliminar
	    if (!"admin".equalsIgnoreCase(usuarioSesion.getTipoUsuario())) {
	        return "redirect:/usuario";
	    }

	    try {
	        // 3️⃣ Obtener el usuario a borrar
	        UsuarioDto usuarioABorrar = usuarioServicio.obtenerUsuarioPorId(id);

	        if (usuarioABorrar == null) {
	            redirectAttributes.addFlashAttribute("error", "El usuario no existe.");
	            return "redirect:/usuarios/listar";
	        }

	        // 🚫 4️⃣ PROHIBIDO borrar admins
	        if ("admin".equalsIgnoreCase(usuarioABorrar.getTipoUsuario())) {
	            redirectAttributes.addFlashAttribute(
	                    "error",
	                    "No se pueden eliminar usuarios con rol ADMIN."
	            );
	            return "redirect:/usuarios/listar";
	        }

	        // 5️⃣ Eliminar
	        String resultado = usuarioServicio.eliminarUsuario(id);

	        if ("success".equalsIgnoreCase(resultado)) {
	            redirectAttributes.addFlashAttribute(
	                    "mensaje",
	                    "Usuario eliminado correctamente."
	            );
	        } else {
	            redirectAttributes.addFlashAttribute(
	                    "error",
	                    "No se pudo eliminar el usuario."
	            );
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        redirectAttributes.addFlashAttribute(
	                "error",
	                "Error inesperado al eliminar el usuario."
	        );
	    }

	    return "redirect:/usuarios/listar";
	}
	
	@GetMapping("/usuario")
	public String usuario() {
	    return "usuario";
	}
	

    /**
     * Permite al usuario ver sus propios pedidos.
     */
	@GetMapping("/usuarios/misPedidos")
	public String verMisPedidos(HttpSession session, Model model) {

	    UsuarioDto usuarioSesion = (UsuarioDto) session.getAttribute("usuario");

	    if (usuarioSesion == null) {
	        return "redirect:/";
	    }

	    try {
	        List<PedidoDto> pedidos = pedidoServicio.listarPorUsuario(usuarioSesion.getIdUsuario());
	        model.addAttribute("pedidos", pedidos);
	    } catch (Exception e) {
	        e.printStackTrace();
	        model.addAttribute("error", "No se pudieron cargar los pedidos");
	    }

	    return "misPedidos";
	}
	
	/**
	 * Muestra el formulario para solicitar recuperación de contraseña.
	 */
	@GetMapping("/recuperar")
	public String mostrarRecuperar() {
	    return "recuperar";
	}

	/**
	 * Procesa la solicitud de recuperación de contraseña.
	 * - Envía un enlace al correo si existe.
	 * - Muestra un mensaje informativo.
	 */
	@PostMapping("/recuperar")
	public String recuperar(@RequestParam String correoElectronico, Model model) {

	    boolean enviado =
	            usuarioServicio.enviarEnlaceRecuperacion(correoElectronico);

	    model.addAttribute("mensaje",
	            enviado
	            ? "Si el correo existe, recibirás un enlace."
	            : "No se pudo procesar la solicitud.");

	    return "recuperar";
	}
	
	 /**
     * Devuelve la foto del usuario.
     * Si no existe, carga una imagen por defecto.
     */
	@GetMapping("/verFoto/{id}")
	public ResponseEntity<byte[]> verFoto(@PathVariable Long id) {

	    String url = "http://localhost:8083/api/usuarios/" + id + "/foto";
	    RestTemplate restTemplate = new RestTemplate();

	    try {
	        byte[] imagen = restTemplate.getForObject(url, byte[].class);

	        return ResponseEntity.ok()
	                .header("Content-Type", "image/jpeg")
	                .body(imagen);

	    } catch (Exception e) {

	        System.out.println("⚠️ Usuario sin foto, mostrando imagen por defecto.");

	        try {
	            InputStream is = getClass().getClassLoader()
	                    .getResourceAsStream("static/img/default-user.png");

	            if (is == null) {
	                System.out.println("❌ NO SE ENCONTRÓ LA IMAGEN DEFAULT");
	                return ResponseEntity.notFound().build();
	            }

	            byte[] imagenDefault = is.readAllBytes();

	            return ResponseEntity.ok()
	                    .header("Content-Type", "image/png")
	                    .body(imagenDefault);

	        } catch (IOException ex) {
	            ex.printStackTrace();
	            return ResponseEntity.notFound().build();
	        }
	    }
	}


	@PostMapping("/usuarios/subirFoto")
	public String subirFoto(@RequestParam("imagenPerfil") MultipartFile imagen,
	                        HttpSession session) {

	    System.out.println("ENTRANDO A SUBIR FOTO WEB");

	    UsuarioDto usuario = (UsuarioDto) session.getAttribute("usuario");

	    if (usuario == null) {
	        System.out.println("USUARIO NULL");
	        return "redirect:/";
	    }

	    System.out.println("ID USUARIO: " + usuario.getIdUsuario());

	    usuarioServicio.subirFoto(usuario.getIdUsuario(), imagen);

	    return "redirect:/usuario";
	}
	
	
	}
	
	

	
	

