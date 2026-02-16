package com.maximacarga.dtos;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)

public class PedidoDto {

    private Long id;                 // <- coincide con API
    private Long usuarioId;
    private LocalDateTime fecha;     // fechaCreacion
    private LocalDateTime fechaEntrega;
    private String nombreUsuario; 
    
    private BigDecimal subtotal;
    private BigDecimal total;
    private String estado;           // sencillo en web (EN_PREPARACION, ENVIADO...)

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getUsuarioId() { return usuarioId; }
    public void setUsuarioId(Long usuarioId) { this.usuarioId = usuarioId; }

    public LocalDateTime getFecha() { return fecha; }
    public void setFecha(LocalDateTime fecha) { this.fecha = fecha; }

    public LocalDateTime getFechaEntrega() { return fechaEntrega; }
    public void setFechaEntrega(LocalDateTime fechaEntrega) { this.fechaEntrega = fechaEntrega; }

    public BigDecimal getSubtotal() { return subtotal; }
    public void setSubtotal(BigDecimal subtotal) { this.subtotal = subtotal; }

    public BigDecimal getTotal() { return total; }
    public void setTotal(BigDecimal total) { this.total = total; }

    private List<PedidoLineaDto> lineas;

    public List<PedidoLineaDto> getLineas() {
        return lineas;
    }

    public void setLineas(List<PedidoLineaDto> lineas) {
        this.lineas = lineas;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}
