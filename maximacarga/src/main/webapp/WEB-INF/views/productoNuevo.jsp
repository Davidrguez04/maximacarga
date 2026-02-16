<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Agregar Producto - Máxima Carga</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <style>
        body {
            background-color: #0b1120;
            color: #e5e7eb;
            font-family: 'Segoe UI', sans-serif;
        }
        .top-bar {
            background-color: #000;
            color: #fff;
            font-size: .85rem;
        }
        .card-form {
            border-radius: 1rem;
            background: #f9fafb;
            color: #111827;
            box-shadow: 0 18px 45px rgba(15,23,42,.18);
            padding: 2rem;
        }
        .footer-admin {
            background-color: #020617;
            color: #9ca3af;
            font-size: .85rem;
        }
        .btn-main {
            background: linear-gradient(90deg, #f97316, #ea580c);
            border: none;
            color: #111827;
            font-weight: 600;
        }
        .btn-main:hover { filter: brightness(1.1); }
    </style>
</head>

<body class="d-flex flex-column min-vh-100">

<!-- BARRA SUPERIOR -->
<div class="top-bar">
    <div class="container-xxl py-2 d-flex justify-content-between align-items-center">
        <span class="fw-semibold text-uppercase">Panel administrador | Agregar producto</span>

        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/admin" class="btn btn-sm btn-outline-light">
                <i class="fas fa-tools me-1"></i> Panel admin
            </a>
            <a href="${pageContext.request.contextPath}/cerrarSesion" class="btn btn-sm btn-outline-light">
                <i class="fas fa-sign-out-alt me-1"></i> Cerrar sesión
            </a>
        </div>
    </div>
</div>

<!-- CONTENIDO -->
<main class="container-xxl my-4 flex-grow-1">
    <div class="row justify-content-center">
        <div class="col-lg-6">

            <div class="card-form">

                <h3 class="fw-bold mb-3 text-center">Agregar nuevo producto</h3>

                <!-- Mensajes -->
                <c:if test="${not empty mensaje}">
                    <div class="alert alert-success">${mensaje}</div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <!-- FORMULARIO -->
                <form action="${pageContext.request.contextPath}/productos/guardar" 
                      method="post"
                      enctype="multipart/form-data">

                    <!-- NOMBRE -->
                    <div class="mb-3">
                        <label class="form-label">Nombre del producto</label>
                        <input type="text" name="nombre" class="form-control" required>
                    </div>

                    <!-- DESCRIPCIÓN -->
                    <div class="mb-3">
                        <label class="form-label">Descripción</label>
                        <textarea name="descripcion" class="form-control" rows="3" required></textarea>
                    </div>

                    <!-- PRECIO -->
                    <div class="mb-3">
                        <label class="form-label">Precio (€)</label>
                        <input type="number" step="0.01" name="precio" class="form-control" required>
                    </div>

                    <!-- STOCK -->
                    <div class="mb-3">
                        <label class="form-label">Stock disponible</label>
                        <input type="number" name="stock" class="form-control" required>
                    </div>

                    <!-- IMAGEN -->
                    <div class="mb-3">
                        <label class="form-label">Imagen del producto</label>
                        <input type="file" name="imagenProducto" class="form-control" accept="image/*" required>
                    </div>

                    <button type="submit" class="btn btn-main w-100 mt-3">
                        Guardar producto
                    </button>
                </form>

                <!-- BOTÓN VOLVER -->
                <div class="text-center mt-3">
                    <a href="${pageContext.request.contextPath}/admin" class="btn btn-outline-secondary">
                        Volver al panel
                    </a>
                </div>

            </div>
        </div>
    </div>
</main>

<!-- FOOTER -->
<footer class="footer-admin py-3 mt-auto">
    <div class="container-xxl d-flex justify-content-between">
        <span>© 2025 Máxima Carga</span>
        <strong class="text-white">MÁXIMACARGA</strong>
    </div>
</footer>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
</body>
</html>