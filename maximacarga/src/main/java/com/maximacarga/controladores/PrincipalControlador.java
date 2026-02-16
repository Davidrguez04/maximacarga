package com.maximacarga.controladores;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * Controlador principal de la aplicación web.
 * Gestiona la carga de la página inicial.
 */
@Controller
public class PrincipalControlador {
	
	  /**
     * Muestra la página principal del sitio.
     * Se ejecuta cuando el usuario accede a la raíz ("/").
     *
     * @return Vista "inicioUsuario".
     */
	@GetMapping("/")
    public String index() {
        return "inicioUsuario"; // Carga /WEB-INF/views/inicioUsuario.jsp
    }

}
