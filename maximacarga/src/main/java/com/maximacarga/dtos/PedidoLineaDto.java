package com.maximacarga.dtos;

import java.math.BigDecimal;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class PedidoLineaDto {

    private String nombreProducto;
    private Integer cantidad;
    private BigDecimal precioUnitario;   // 🔥 nombre correcto
    private BigDecimal subtotal;

    public String getNombreProducto() {
        return nombreProducto;
    }

    public void setNombreProducto(String nombreProducto) {
        this.nombreProducto = nombreProducto;
    }

    public Integer getCantidad() {
        return cantidad;
    }

    public void setCantidad(Integer cantidad) {
        this.cantidad = cantidad;
    }

    public BigDecimal getPrecioUnitario() {   // 🔥 getter correcto
        return precioUnitario;
    }

    public void setPrecioUnitario(BigDecimal precioUnitario) {   // 🔥 setter correcto
        this.precioUnitario = precioUnitario;
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }
}
