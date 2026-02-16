package com.maximacarga.controladores;

	import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.maximacarga.dtos.ProductoDto;
import com.maximacarga.dtos.UsuarioDto;
import com.maximacarga.servicios.ProductoServicio;
import com.maximacarga.servicios.PedidoServicio;

import jakarta.servlet.http.HttpSession;

/**
 * Controlador encargado de la parte web del catálogo.
 * Gestiona la visualización de productos, carrito y proceso de compra.
 */
	@Controller
	public class CatalogoControlador {

		@Autowired
		private PedidoServicio pedidoServicio; 
	    private final ProductoServicio productoServicio;
		
		     

	    public CatalogoControlador(ProductoServicio productoServicio) {
	        this.productoServicio = productoServicio;
	    }

	    /**
	     * Muestra la página principal del catálogo.
	     * - Carga todos los productos desde la API.
	     * - Calcula el número total de productos en el carrito.
	     */
	    @GetMapping("/catalogo")
	    public String verCatalogo(Model model,
	                              HttpSession session,
	                              RedirectAttributes redirectAttributes) {
	        try {
	            List<ProductoDto> productos = productoServicio.obtenerTodos();
	            model.addAttribute("productos", productos);

	            // Carrito simple en sesión: Map<idProducto, cantidad>
	            Map<Long, Integer> carrito =
	                    (Map<Long, Integer>) session.getAttribute("carrito");
	            int totalItems = 0;
	            if (carrito != null) {
	                totalItems = carrito.values().stream().mapToInt(Integer::intValue).sum();
	            }
	            model.addAttribute("totalItemsCarrito", totalItems);

	            return "catalogo";

	        } catch (IOException | URISyntaxException e) {
	            e.printStackTrace();
	            redirectAttributes.addFlashAttribute(
	                    "errorCatalogo",
	                    "No se pudieron cargar los productos. Inténtalo más tarde."
	            );
	            return "redirect:/";
	        }
	    }

	    /**
	     * Añade un producto al carrito almacenado en sesión.
	     * Incrementa la cantidad si ya existe.
	     */
	    @PostMapping("/carrito/agregar")
	    public String agregarAlCarrito(@RequestParam("idProducto") Long idProducto,
	                                   HttpSession session,
	                                   RedirectAttributes redirectAttributes) {

	        Map<Long, Integer> carrito =
	                (Map<Long, Integer>) session.getAttribute("carrito");

	        if (carrito == null) {
	            carrito = new HashMap<>();
	        }

	        carrito.merge(idProducto, 1, Integer::sum); // suma 1 unidad
	        session.setAttribute("carrito", carrito);

	        redirectAttributes.addFlashAttribute(
	                "mensajeCarrito",
	                "Producto añadido al carrito correctamente."
	        );

	        return "redirect:/catalogo";
	    }

	    /**
	     * Clase auxiliar utilizada para representar cada línea del carrito en la vista.
	     */
	    public static class CarritoLinea {
	        private ProductoDto producto;
	        private int cantidad;
	        private double subtotal;

	        public CarritoLinea(ProductoDto producto, int cantidad) {
	            this.producto = producto;
	            this.cantidad = cantidad;
	            this.subtotal = (producto.getPrecio() != null ? producto.getPrecio() : 0.0) * cantidad;
	        }

	        public ProductoDto getProducto() { return producto; }
	        public int getCantidad() { return cantidad; }
	        public double getSubtotal() { return subtotal; }
	    }

	    /**
	     * Muestra el contenido del carrito.
	     * Calcula subtotales y total general.
	     */
	    @GetMapping("/carrito")
	    public String verCarrito(HttpSession session,
	                             Model model,
	                             RedirectAttributes redirectAttributes) {
	        try {
	            Map<Long, Integer> carrito =
	                    (Map<Long, Integer>) session.getAttribute("carrito");

	            if (carrito == null || carrito.isEmpty()) {
	                model.addAttribute("lineasCarrito", new ArrayList<CarritoLinea>());
	                model.addAttribute("totalCarrito", 0.0);
	                return "carrito";
	            }

	            // Cogemos todos los productos de la API y filtramos por los IDs del carrito
	            List<ProductoDto> todos = productoServicio.obtenerTodos();

	            List<CarritoLinea> lineas = new ArrayList<>();
	            double total = 0.0;

	            for (ProductoDto p : todos) {
	                Integer cantidad = carrito.get(p.getIdProducto());
	                if (cantidad != null && cantidad > 0) {
	                    CarritoLinea linea = new CarritoLinea(p, cantidad);
	                    lineas.add(linea);
	                    total += linea.getSubtotal();
	                }
	            }

	            model.addAttribute("lineasCarrito", lineas);
	            model.addAttribute("totalCarrito", total);

	            return "carrito";

	        } catch (IOException | URISyntaxException e) {
	            e.printStackTrace();
	            redirectAttributes.addFlashAttribute(
	                    "errorCatalogo",
	                    "No se pudo cargar el carrito. Inténtalo más tarde."
	            );
	            return "redirect:/catalogo";
	        }
	    }
	    
	    /**
	     * Procesa la compra del carrito actual.
	     * - Verifica que haya usuario logueado.
	     * - Envía los datos a la API.
	     * - Limpia el carrito de la sesión.
	     */
	    @PostMapping("/carrito/comprar")
	    public String comprar(HttpSession session) {

	        UsuarioDto usuario = (UsuarioDto) session.getAttribute("usuario");
	        Map<Long, Integer> carrito =
	            (Map<Long, Integer>) session.getAttribute("carrito");

	        if (usuario == null || carrito == null || carrito.isEmpty()) {
	            return "redirect:/carrito";
	        }

	        pedidoServicio.comprar(usuario.getIdUsuario(), carrito);

	        session.removeAttribute("carrito");
	        return "redirect:/carrito";
	    }
	    
	    /**
	     * Muestra una vista alternativa del catálogo.
	     */
	    @GetMapping("/catalogoVista")
	    public String mostrarCatalogoVista(Model model) {

	        try {
	            model.addAttribute("productos", productoServicio.obtenerTodos());
	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        return "catalogoVista";
	    }
	}
	

