package com.maximacarga.controladores;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.maximacarga.dtos.ProductoDto;
import com.maximacarga.dtos.UsuarioDto;
import com.maximacarga.servicios.ProductoServicio;

import jakarta.servlet.http.HttpSession;

/**
 * Controlador web encargado de la gestión de productos.
 * Permite crear, listar, eliminar y modificar productos desde la vista.
 */
@Controller
@RequestMapping("/productos")   // prefijo para todas las rutas de este controlador
public class ProductoControlador { 

		private String apiUrl = "http://localhost:8083/api";
	    private final RestTemplate restTemplate = new RestTemplate();
	    
	/**
	* Muestra el formulario para crear un nuevo producto.
	*/
    @GetMapping("/productoNuevo")
    public String mostrarFormularioAgregarProducto() {
    return "productoNuevo"; // Carga productoNuevo.jsp
    }

    private final ProductoServicio productoServicio;

    public ProductoControlador(ProductoServicio productoServicio) {
        this.productoServicio = productoServicio;
    }

    /**
     * Muestra el panel de administración para agregar productos.
     * Solo accesible para usuarios admin.
     */
    @GetMapping("/agregar")
    public String mostrarFormularioAgregarProducto(HttpSession session) {
        // Proteger con login
        if (session.getAttribute("usuario") == null) {
            return "redirect:/";
        }

        UsuarioDto u = (UsuarioDto) session.getAttribute("usuario");
        if (u == null || !"admin".equalsIgnoreCase(u.getTipoUsuario())) {
            return "redirect:/usuario";
        }

        return "admin";  // /WEB-INF/views/agregarProducto.jsp
    }

    /**
    * Procesa el formulario de creación de producto.
    * Envía los datos a la API mediante el servicio.
    */
    @PostMapping("/guardar")
    public String guardarProducto(@RequestParam String nombre,
                                  @RequestParam String descripcion,
                                  @RequestParam Double precio,
                                  @RequestParam Integer stock,
                                  @RequestParam("imagenProducto") MultipartFile imagen,
                                  HttpSession session,
                                  RedirectAttributes redirectAttributes) {

        try {
            if (session.getAttribute("usuario") == null) {
                redirectAttributes.addFlashAttribute("error", "Debes iniciar sesión.");
                return "redirect:/";
            }

            String resultado = productoServicio.guardarProducto(
                    nombre, descripcion, precio, stock, imagen
            );

            if ("success".equalsIgnoreCase(resultado)) {
                redirectAttributes.addFlashAttribute("mensaje", "Producto guardado correctamente.");
            } else {
                redirectAttributes.addFlashAttribute("error", "No se pudo guardar el producto.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute(
                    "error",
                    "Error al guardar el producto: " + e.getMessage()
            );
        }

     // 👇 Después de guardar, redirigimos al panel admin
        return "redirect:/admin";
    }


    /**
     * Lista todos los productos.
     */
    @GetMapping("/listar")
    public String listarProductos(HttpSession session, org.springframework.ui.Model model) {
        if (session.getAttribute("usuario") == null) {
            return "redirect:/";
        }

        try {
            java.util.List<com.maximacarga.dtos.ProductoDto> productos =
                    productoServicio.obtenerTodos();
            model.addAttribute("productos", productos);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "No se pudo cargar la lista de productos.");
        }

        return "listaProductos"; // JSP que te he pasado
    }


    /**
     * Elimina un producto por su ID.
     */
    @GetMapping("/eliminar")
    public String eliminarProducto(@RequestParam Long id,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        try {
            if (session.getAttribute("usuario") == null) {
                redirectAttributes.addFlashAttribute("error", "Debes iniciar sesión.");
                return "redirect:/";
            }

            String resultado = productoServicio.eliminarProducto(id);

            if ("success".equalsIgnoreCase(resultado)) {
                redirectAttributes.addFlashAttribute("mensaje", "Producto eliminado correctamente.");
            } else {
                redirectAttributes.addFlashAttribute("error", "No se pudo eliminar el producto.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error",
                    "Error al eliminar el producto: " + e.getMessage());
        }

        return "redirect:/productos/listar"; 
    }
    
    /**
     * Muestra el formulario para modificar un producto existente.
     */
    @GetMapping("/modificar")
    public String mostrarModificar(@RequestParam Long id, Model model, RedirectAttributes redirectAttributes) {

        ProductoDto producto = productoServicio.obtenerProductoPorId(id);

        if (producto == null) {
            redirectAttributes.addFlashAttribute("error", "Producto no encontrado.");
            return "redirect:/productos/listar";
        }

        model.addAttribute("producto", producto);
        return "modificarProducto";
    }
    
    /**
     * Procesa la actualización de un producto.
     * Si se incluye una nueva imagen, se actualiza también.
     */
    @PostMapping("/actualizar")
    public String actualizarProducto(ProductoDto producto,
                                     @RequestParam(required = false) MultipartFile imagen,
                                     RedirectAttributes redirectAttributes) {

        try {

            //  1️Obtener producto actual desde API
            ProductoDto productoExistente =
                    productoServicio.obtenerProductoPorId(producto.getIdProducto());

            if (productoExistente == null) {
                redirectAttributes.addFlashAttribute("error", "Producto no encontrado.");
                return "redirect:/productos/listar";
            }

            //  2️ Mantener imagen anterior si no se sube nueva
            if (imagen != null && !imagen.isEmpty()) {
                producto.setImagenProducto(imagen.getBytes());
            } else {
                producto.setImagenProducto(productoExistente.getImagenProducto());
            }

            //  3️ Enviar producto completo a la API
            String url = apiUrl + "/productos/" + producto.getIdProducto();
            restTemplate.put(url, producto);

            redirectAttributes.addFlashAttribute("mensaje",
                    "Producto actualizado correctamente.");

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error",
                    "Error al actualizar producto.");
        }

        return "redirect:/productos/listar";
    }


}


