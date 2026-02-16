<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect(request.getContextPath() + "/");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Pedidos · Panel Admin</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #020617;
            color: #e5e7eb;
        }
        .card {
            background: #0f172a;
            border: 1px solid rgba(148,163,184,.3);
            border-radius: 1rem;
            box-shadow: 0 20px 40px rgba(0,0,0,.4);
        }
        .table thead {
            background-color: #111827;
            color: #f9fafb;
        }
    </style>
</head>

<body class="d-flex flex-column min-vh-100">

<!-- CABECERA -->
<header class="py-3" style="background:#000;">
    <div class="container-xxl d-flex justify-content-between align-items-center">
        <h5 class="mb-0 text-white">Panel Administrador · Pedidos</h5>
        <a href="${pageContext.request.contextPath}/admin"
           class="btn btn-sm btn-outline-light">
            ← Volver al panel
        </a>
    </div>
</header>

<!-- CONTENIDO -->
<main class="flex-grow-1 py-4">
    <div class="container-xxl">

        <div class="card">
            <div class="card-body">

                <h4 class="fw-bold mb-3">Listado de pedidos</h4>

                <c:choose>
                    <c:when test="${empty pedidos}">
                        <div class="alert alert-warning">
                            No hay pedidos registrados.
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
    <thead>
    <tr>
        <th>ID Pedido</th>
        <th>Nombre Usuario</th>
        <th>Fecha</th>
        <th class="text-end">Total (€)</th>
        <th class="text-center">Acciones</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="pedido" items="${pedidos}">
        <tr>
            <td>${pedido.id}</td>
            <td>${pedido.nombreUsuario}</td>
           <!-- <td>${pedido.usuarioId}</td>-->
            <td>${pedido.fecha}</td>
            <td class="text-end">${pedido.total} €</td>
            <td class="text-center">

                <!-- BOTÓN MODIFICAR -->
                <a href="${pageContext.request.contextPath}/pedidos/editar/${pedido.id}"
                   class="btn btn-sm btn-outline-warning me-1">
                    ✏️
                </a>

                <!-- BOTÓN ELIMINAR -->
                <a href="${pageContext.request.contextPath}/pedidos/eliminar/${pedido.id}"
   class="btn btn-sm btn-outline-danger"
   onclick="return confirm('¿Seguro que quieres eliminar este pedido?');">
    🗑
</a>

            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

                        </div>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>

    </div>
</main>

<!-- FOOTER -->
<footer class="py-3 text-center text-muted small">
    © 2025 Máxima Carga
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
