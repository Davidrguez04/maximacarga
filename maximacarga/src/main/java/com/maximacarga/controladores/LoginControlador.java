package com.maximacarga.controladores;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.maximacarga.dtos.UsuarioDto;
import com.maximacarga.servicios.LoginServicio;

import jakarta.servlet.http.HttpSession;

/**
 * Controlador encargado de la autenticación en la parte web.
 * Gestiona inicio de sesión, cierre de sesión y restablecimiento de contraseña.
 */
@Controller
public class LoginControlador {
	private final LoginServicio loginServicio;

    // Inyección por constructor
    public LoginControlador(LoginServicio loginServicio) {
        this.loginServicio = loginServicio;
    }
    

    /**
     * Procesa el inicio de sesión.
     * - Valida credenciales mediante el LoginServicio.
     * - Verifica si la cuenta está activada.
     * - Redirige según el tipo de usuario (admin o usuario).
     */
	@PostMapping("/iniciarSesion")
	public String iniciarSesion(@RequestParam("email") String email,
	                            @RequestParam("contrasenia") String contrasenia,
	                            HttpSession sesion,
	                            RedirectAttributes redirectAttributes) {
		System.out.println("Intentando iniciar sesión con el email: "+ email);

	    try {
	        String resultado = loginServicio.iniciarSesion(email, contrasenia, sesion);
	        System.out.println("Resultado del loginServicio: {}"+ resultado);

	        UsuarioDto usuario = (UsuarioDto) sesion.getAttribute("usuario");

	        if (usuario != null) {
	            if (usuario.getActivo() == null || !usuario.getActivo()) {
	                redirectAttributes.addFlashAttribute("errorLogin", "Tu cuenta aún no está activada.");
	                sesion.invalidate();
	                return "redirect:/";
	            }
	            // Según rol, envía a la vista adecuada
	            return "admin".equalsIgnoreCase(usuario.getTipoUsuario()) ? "admin" : "usuario";
	        } else {
	            redirectAttributes.addFlashAttribute("errorLogin", "Credenciales incorrectas.");
	            return "redirect:/";
	        }

	    } catch (Exception e) {
	        System.out.println("Error durante el login para el email: {}"+ email + ","+  e);
	        redirectAttributes.addFlashAttribute("errorLogin", "Error inesperado. Inténtalo de nuevo.");
	        return "redirect:/";
	    }
	}
	
	/**
     * Cierra la sesión del usuario invalidando la sesión actual.
     */
	@GetMapping("/cerrarSesion")
    public String cerrarSesion(HttpSession sesion) {
        

        try {
            sesion.invalidate();
            
        } catch (Exception e) {
            
        }

        return "redirect:/";
    }
	
	
	 /**
     * Muestra la vista para restablecer contrasenia.
     * Recibe el token por parámetro.
     */
	@GetMapping("/restablecerContrasenia")
	public String mostrarRestablecer(@RequestParam("token") String token, Model model) {

	    model.addAttribute("token", token);

	    return "restablecerContrasenia"; // JSP
	}

	  /**
     * Procesa el cambio de contrasenia.
     * - Verifica que ambas contraseñas coincidan.
     * - Valida el token.
     * - Redirige si la operación es correcta.
     */
	@PostMapping("/restablecerContrasenia")
	public String procesarRestablecer(@RequestParam String token,
	                                  @RequestParam String nuevaContrasenia,
	                                  @RequestParam String repNuevaContrasenia,
	                                  Model model) {

	    try {

	        if (!nuevaContrasenia.equals(repNuevaContrasenia)) {
	            model.addAttribute("error", "Las contraseñas no coinciden.");
	            model.addAttribute("token", token);
	            return "restablecerContrasenia";
	        }

	        boolean resultado =
	                loginServicio.restablecerContrasenia(token, nuevaContrasenia);

	        if (resultado) {
	            return "redirect:/";
	        } else {
	            model.addAttribute("error", "Token inválido o expirado.");
	            model.addAttribute("token", token);
	            return "restablecerContrasenia";
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        model.addAttribute("error", "Error inesperado.");
	        model.addAttribute("token", token);
	        return "restablecerContrasenia";
	    }
	}


}
