package com.maximacarga.controladores;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;

import com.maximacarga.dtos.UsuarioDto;

import ch.qos.logback.core.model.Model;
import jakarta.servlet.http.HttpSession;

/**
 * Controlador encargado únicamente de devolver vistas estáticas.
 * No contiene lógica de negocio, solo navegación entre páginas.
 */
@Controller
public class VistasControlador {
	
	 /**
     * Muestra la página de registro de usuario.
     */
	  @GetMapping("/registro")
	    public String registro() {
	        return "registroUsuario"; // /WEB-INF/jsp/registroUsuario.jsp
	    }
	  
	  /**
	     * Muestra la página de login.
	     */
	  @GetMapping("/login")
	    public String mostrarLogin(Model model) {
	        return "inicioUsuario"; // Carga WEB-INF/views/login.jsp
	    }

	  /**
	     * Muestra el panel de administración.
	     * Solo accesible si el usuario en sesión tiene rol admin.
	     */
	  @GetMapping("/admin")
	    public String volverAlAdmin(HttpSession session) {
	        UsuarioDto usuario = (UsuarioDto) session.getAttribute("usuario");
	        if (usuario == null || !"admin".equalsIgnoreCase(usuario.getTipoUsuario())) {
	            return "redirect:/"; // no es admin → inicio
	        }
	        return "admin"; // muestra admin.jsp
	    }
	  

	  /**
	     * Muestra la página de ayuda.
	     */
	    @GetMapping("/ayuda")
	    public String mostrarAyuda() {
	        return "ayuda"; // Spring busca /WEB-INF/views/ayuda.jsp
	    }
	    
	    /**
	     * Muestra la página de marcas.
	     */
	    @GetMapping("/marcas")
	    public String marcas() {
	        return "marcas";
	    }

	    /**
	     * Muestra la página de ofertas.
	     */
	    @GetMapping("/ofertas")
	    public String ofertas() {
	        return "ofertas";
	    }
	   
	    


}
