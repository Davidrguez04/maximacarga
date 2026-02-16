<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect(request.getContextPath() + "/");
        return;
    }
    response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de productos - Máxima Carga</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet"
        crossorigin="anonymous">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #0b1120;
            color: #e5e7eb;
        }
        .top-bar {
            background-color: #000;
            color: #fff;
            font-size: .85rem;
        }
        .top-bar .btn {
            font-size: .75rem;
            padding-inline: .75rem;
            padding-block: .25rem;
        }
        .page-wrapper {
            padding: 2.5rem 0;
        }
        .card-products {
            border-radius: 1rem;
            border: none;
            background: #f9fafb;
            color: #111827;
            box-shadow: 0 18px 45px rgba(15,23,42,.18);
        }
        .card-products .card-title {
            font-weight: 700;
        }
        .table thead {
            background-color: #111827;
            color: #f9fafb;
        }
        .footer-admin {
            background-color: #020617;
            color: #9ca3af;
            font-size: .85rem;
        }
        .product-image {
            width: 64px;
            height: 64px;
            object-fit: cover;
            border-radius: .5rem;
            border: 1px solid rgba(0,0,0,.1);
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

<!-- Barra superior -->
<div class="top-bar">
    <div class="container-xxl">
        <div class="d-flex flex-wrap justify-content-between align-items-center py-2 gap-2">
            <div class="d-flex align-items-center gap-2">
                <span class="fw-semibold text-uppercase">Panel administrador</span>
                <span class="text-white-50 d-none d-sm-inline">| Gestión de productos</span>
            </div>
            <div class="d-flex flex-wrap align-items-center gap-2">
                <span class="text-white-50">
                    Conectado como
                    <strong>${sessionScope.usuario.nombreUsuario}</strong>
                </span>
                <a class="btn btn-sm btn-outline-light"
                   href="${pageContext.request.contextPath}/admin">
                    <i class="fas fa-tools me-1"></i> Panel admin
                </a>
                <a class="btn btn-sm btn-outline-light"
                   href="${pageContext.request.contextPath}/cerrarSesion">
                    <i class="fas fa-sign-out-alt me-1"></i> Cerrar sesión
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Contenido -->
<main class="page-wrapper flex-grow-1">
    <div class="container-xxl">
        <div class="card card-products">
            <div class="card-body">

                <!-- Mensajes -->
                <c:if test="${not empty mensaje}">
                    <div class="alert alert-success">${mensaje}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                    <div>
                        <h5 class="card-title mb-1">
                            <i class="fas fa-dumbbell me-2"></i> Productos en catálogo
                        </h5>
                        <p class="mb-0 text-muted" style="font-size:.9rem;">
                            Aquí puedes ver, modificar o eliminar productos.
                        </p>
                    </div>
                    <a href="${pageContext.request.contextPath}/productos/productoNuevo"
                       class="btn btn-outline-dark btn-sm">
                        <i class="fas fa-plus me-1"></i> Agregar producto
                    </a>
                </div>

                <div class="table-responsive">
                    <table class="table align-middle mb-0">
                        <thead>
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Imagen</th>
                            <th scope="col">Nombre</th>
                            <th scope="col">Descripción</th>
                            <th scope="col">Precio (€)</th>
                            <th scope="col">Stock</th>
                            <th scope="col" class="text-end">Acciones</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="p" items="${productos}">
                            <tr>
                                <td>${p.idProducto}</td>

                                <!-- ✅ Imagen desde API -->
                                <td>
                                    <img class="product-image"
                                         src="http://localhost:8083/api/productos/${p.idProducto}/imagen"
                                         alt="Imagen ${p.nombre}"
                                         onerror="this.style.display='none'; this.parentElement.innerHTML='<span class=&quot;text-muted&quot; style=&quot;font-size:.8rem;&quot;>Sin imagen</span>';"/>
                                </td>

                                <td>${p.nombre}</td>
                                <td>${p.descripcion}</td>
                                <td>${p.precio}</td>
                                <td>${p.stock}</td>

                                <td class="text-end">
                                    <!-- MODIFICAR -->
                                    <a href="${pageContext.request.contextPath}/productos/modificar?id=${p.idProducto}"
										   class="btn btn-warning btn-sm">
										    Modificar
										</a>

                                    <!-- ELIMINAR -->
                                    <form action="${pageContext.request.contextPath}/productos/eliminar"
                                          method="get"
                                          class="d-inline"
                                          onsubmit="return confirm('¿Seguro que deseas eliminar este producto?');">
                                        <input type="hidden" name="id" value="${p.idProducto}">
                                        <button type="submit" class="btn btn-sm btn-outline-danger">
                                            <i class="fas fa-trash-alt"></i> Eliminar
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty productos}">
                            <tr>
                                <td colspan="7" class="text-center text-muted py-4">
                                    No hay productos para mostrar.
                                </td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </div>
</main>

<!-- Footer -->
<footer class="footer-admin py-3 mt-auto">
    <div class="container-xxl d-flex justify-content-between align-items-center">
        <span>© 2025 Máxima Carga</span>
        <div class="d-flex align-items-center gap-2">
            <strong class="text-white">MÁXIMACARGA</strong>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
</body>
</html>
