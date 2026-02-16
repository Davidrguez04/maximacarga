package com.maximacarga.controladores;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.maximacarga.dtos.PedidoDto;
import com.maximacarga.servicios.PedidoServicio;

import jakarta.servlet.http.HttpSession;

/**
 * Controlador web encargado de la gestión de pedidos.
 * Permite listar, editar, actualizar y eliminar pedidos desde la vista.
 */
@Controller
public class PedidosControlador {

    private final PedidoServicio pedidoServicio;

    public PedidosControlador(PedidoServicio pedidoServicio) {
        this.pedidoServicio = pedidoServicio;
    }

    /**
     * Muestra la lista de pedidos.
     * - Verifica que el usuario esté autenticado.
     * - Carga todos los pedidos desde la API.
     */
    @GetMapping("/pedidos/listar")
    public String listarPedidos(Model model, HttpSession session) {

        if (session.getAttribute("usuario") == null) {
            return "redirect:/";
        }

        List<PedidoDto> pedidos = pedidoServicio.listarTodos();
        model.addAttribute("pedidos", pedidos);

        return "listaPedidos";
    }
    
    /**
     * Muestra la vista de edición de un pedido.
     * Obtiene el pedido por su ID.
     */
    @GetMapping("/pedidos/editar/{id}")
    public String editarPedido(@PathVariable Long id, Model model) {

        PedidoDto pedido = pedidoServicio.obtenerPorId(id);

        model.addAttribute("pedido", pedido);

        return "editarPedido";
    }
    

    /**
     * Procesa la actualización de un pedido.
     * Envía los nuevos datos al servicio.
     */
    @PostMapping("/pedidos/editar/{id}")
    public String actualizarPedido(@PathVariable Long id,
                                    @ModelAttribute PedidoDto pedido) {

        pedidoServicio.actualizarPedido(id, pedido);

        return "redirect:/pedidos/listar";
    }
    
    /**
     * Elimina un pedido por su ID.
     */
    @GetMapping("/pedidos/eliminar/{id}")
    public String eliminarPedido(@PathVariable Long id) {

        pedidoServicio.eliminarPedido(id);

        return "redirect:/pedidos/listar";
    }
    
  

    
    
}