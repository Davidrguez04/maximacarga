<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.maximacarga.dtos.PedidoDto" %>
<%@ page import="com.maximacarga.dtos.PedidoLineaDto" %>

<%
    List<PedidoDto> pedidos = (List<PedidoDto>) request.getAttribute("pedidos");
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Mis Pedidos • Máxima Carga</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    background: linear-gradient(135deg,#0b0f1a 0%, #111c35 100%);
    color: #fff;
    min-height: 100vh;
}

.header-bar {
    background:#000;
    padding:1rem 2rem;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.brand {
    font-weight:700;
    letter-spacing:1px;
}

.page-title {
    margin:2rem 0;
    font-weight:700;
}

.pedido-card {
    background:rgba(255,255,255,0.05);
    backdrop-filter:blur(10px);
    border:1px solid rgba(255,255,255,0.1);
    border-radius:20px;
    padding:1.5rem;
    margin-bottom:2rem;
    transition:all .3s ease;
}

.pedido-card:hover {
    transform:translateY(-5px);
    box-shadow:0 15px 35px rgba(0,0,0,.4);
}

.estado-badge {
    background:#ffc107;
    color:#000;
    font-weight:600;
    padding:.4rem .8rem;
    border-radius:50px;
    font-size:.8rem;
}

.linea-producto {
    background:rgba(255,255,255,0.03);
    padding:.8rem 1rem;
    border-radius:12px;
    margin-top:.6rem;
}

.producto-nombre {
    font-weight:600;
}

.total-pedido {
    font-size:1.1rem;
    font-weight:700;
    margin-top:1rem;
    color:#ffc107;
}

.btn-volver {
    border-radius:30px;
}
</style>
</head>

<body>

<div class="header-bar">
    <div class="brand">MÁXIMA CARGA</div>
    <a href="${pageContext.request.contextPath}/usuario"
       class="btn btn-outline-light btn-sm btn-volver">
        Volver a mi área
    </a>
</div>

<div class="container">

    <h2 class="page-title">🚀 Mis Pedidos</h2>

<%
    if (pedidos == null || pedidos.isEmpty()) {
%>
        <div class="alert alert-warning text-dark">
            No tienes pedidos todavía.
        </div>
<%
    } else {
        for (PedidoDto pedido : pedidos) {
%>

        <div class="pedido-card">

            <div class="d-flex justify-content-between align-items-center">
                <h5>Pedido #<%= pedido.getId() %></h5>
                <span class="estado-badge">
                    <%= pedido.getEstado() %>
                </span>
            </div>

            <p class="mt-2">
                <strong>Fecha:</strong> <%= pedido.getFecha() %>
            </p>

            <hr style="border-color:rgba(255,255,255,0.1);">

            <!-- PRODUCTOS -->
<%
            if (pedido.getLineas() != null) {
                for (PedidoLineaDto linea : pedido.getLineas()) {
%>

                <div class="linea-producto">
                    <div class="producto-nombre">
                        <%= linea.getNombreProducto() %>
                    </div>
                    <div>
                        Cantidad: <%= linea.getCantidad() %> |
                        Precio unitario: € <%= linea.getPrecioUnitario() %> |
                        
                    </div>
                </div>

<%
                }
            }
%>

            <div class="total-pedido">
                Total pedido: € <%= pedido.getTotal() %>
            </div>

        </div>

<%
        }
    }
%>

</div>

</body>
</html>
