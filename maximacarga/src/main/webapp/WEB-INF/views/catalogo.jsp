<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Catálogo de productos · Máxima Carga</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>

    <style>
        body {
            background: radial-gradient(circle at top left, #f97316 0, #020617 40%, #020617 100%);
            color: #e5e7eb;
            font-family: 'Segoe UI', sans-serif;
        }
        .top-bar {
            background-color: #000;
            color: #fff;
            font-size: .85rem;
        }
        .top-bar a { font-size: .8rem; }
        .page-wrapper { padding: 2.5rem 0; }
        .card-producto {
            border-radius: 1rem;
            background: #0f172a;
            color: #e5e7eb;
            border: 1px solid rgba(148,163,184,.4);
            box-shadow: 0 18px 45px rgba(15,23,42,.5);
            overflow: hidden;
        }
        .card-producto img {
            width: 100%;
            height: 220px;
            object-fit: cover;
        }
        .badge-precio {
            background: linear-gradient(90deg, #f97316, #ea580c);
            color: #111827;
            border-radius: 999px;
            padding: .25rem .9rem;
            font-weight: 600;
        }
        .btn-main {
            background: linear-gradient(90deg, #f97316, #ea580c);
            border: none;
            color: #111827;
            font-weight: 600;
        }
        .btn-main:hover { filter: brightness(1.05); }
        .footer {
            background-color: #020617;
            color: #9ca3af;
            font-size: .85rem;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

<!-- BARRA SUPERIOR -->
<div class="top-bar">
    <div class="container-xxl py-2 d-flex justify-content-between align-items-center">
        <span class="fw-semibold text-uppercase">
            Máxima Carga · Catálogo online
        </span>

        <div class="d-flex align-items-center gap-3">
            <span class="text-white-50 d-none d-md-inline">
                Productos para llevar tu entrenamiento al siguiente nivel.
            </span>
            
            <a href="${pageContext.request.contextPath}/usuario"
       class="btn btn-sm btn-outline-warning">
        <i class="fas fa-user me-1"></i> Mi cuenta
    </a>

            <a href="${pageContext.request.contextPath}/"
               class="btn btn-sm btn-outline-light">
                <i class="fas fa-home me-1"></i> Inicio
            </a>

            <a href="${pageContext.request.contextPath}/carrito"
               class="btn btn-sm btn-warning text-dark">
                <i class="fas fa-shopping-cart me-1"></i>
                Carrito
                <c:if test="${totalItemsCarrito > 0}">
                    (<strong>${totalItemsCarrito}</strong>)
                </c:if>
            </a>
        </div>
    </div>
</div>

<!-- CONTENIDO PRINCIPAL -->
<main class="page-wrapper flex-grow-1">
    <div class="container-xxl">

        <!-- Mensajes -->
        <c:if test="${not empty mensajeCarrito}">
            <div class="alert alert-success">
                ${mensajeCarrito}
            </div>
        </c:if>
        <c:if test="${not empty errorCatalogo}">
            <div class="alert alert-danger">
                ${errorCatalogo}
            </div>
        </c:if>

        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
            <div>
                <h2 class="fw-bold mb-1">Productos en catálogo</h2>
                <p class="mb-0 text-white-50" style="font-size:.9rem;">
                    Explora nuestros productos y añádelos a tu carrito.
                </p>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty productos}">
                <div class="alert alert-info">
                    De momento no hay productos disponibles. Vuelve más tarde.
                </div>
            </c:when>

            <c:otherwise>
                <div class="row g-4">
                    <c:forEach var="p" items="${productos}">
                        <div class="col-sm-6 col-md-4 col-lg-3">
                            <div class="card card-producto h-100">

                                <!-- ✅ Imagen desde API -->
                                <img src="http://localhost:8083/api/productos/${p.idProducto}/imagen"
                                     alt="Imagen ${p.nombre}"
                                     onerror="this.src='https://via.placeholder.com/400x220?text=Producto';">

                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title mb-1">${p.nombre}</h5>
                                    <p class="card-text text-white-50 mb-2" style="font-size:.85rem;">
                                        ${p.descripcion}
                                    </p>

                                    <div class="d-flex justify-content-between align-items-center mt-auto">
                                        <span class="badge-precio">
                                            ${p.precio} €
                                        </span>

                                        <form action="${pageContext.request.contextPath}/carrito/agregar"
                                              method="post" class="ms-2">
                                            <input type="hidden" name="idProducto" value="${p.idProducto}">
                                            <button type="submit" class="btn btn-main btn-sm">
                                                <i class="fas fa-cart-plus me-1"></i> Añadir
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<!-- FOOTER -->
<footer class="footer py-3 mt-auto">
    <div class="container-xxl d-flex justify-content-between align-items-center">
        <span>© 2025 Máxima Carga</span>
        <strong class="text-white">MÁXIMACARGA</strong>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
</body>
</html>
