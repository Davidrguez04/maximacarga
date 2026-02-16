<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Catálogo · Máxima Carga</title>

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

        .page-wrapper {
            padding: 2.5rem 0;
        }

        .card-producto {
            border-radius: 1rem;
            background: #0f172a;
            color: #e5e7eb;
            border: 1px solid rgba(148,163,184,.4);
            box-shadow: 0 18px 45px rgba(15,23,42,.5);
            overflow: hidden;
            transition: 0.3s;
        }

        .card-producto:hover {
            transform: translateY(-6px);
            border-color: #f97316;
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
            padding: .35rem 1rem;
            font-weight: 600;
            font-size: .9rem;
        }

        .footer {
            background-color: #020617;
            color: #9ca3af;
            font-size: .85rem;
        }

        .btn-inicio {
            border-radius: 999px;
            border: 1px solid #fff;
            padding: .35rem 1rem;
            background: transparent;
            color: #fff;
            font-size: .8rem;
        }

        .btn-inicio:hover {
            background: #f97316;
            border-color: #f97316;
            color: #111827;
        }
    </style>
</head>

<body class="d-flex flex-column min-vh-100">

<!-- BARRA SUPERIOR -->
<div class="top-bar">
    <div class="container-xxl py-2 d-flex justify-content-between align-items-center">
        <span class="fw-semibold text-uppercase">
            Máxima Carga · Catálogo
        </span>

        <a href="${pageContext.request.contextPath}/"
           class="btn btn-inicio">
            <i class="fas fa-home me-1"></i> Inicio
        </a>
    </div>
</div>

<!-- CONTENIDO PRINCIPAL -->
<main class="page-wrapper flex-grow-1">
    <div class="container-xxl">

        <div class="mb-4">
            <h2 class="fw-bold mb-1">Productos disponibles</h2>
            <p class="mb-0 text-white-50" style="font-size:.9rem;">
                Explora nuestro catálogo completo de productos.
            </p>
        </div>

        <c:choose>
            <c:when test="${empty productos}">
                <div class="alert alert-info">
                    De momento no hay productos disponibles.
                </div>
            </c:when>

            <c:otherwise>
                <div class="row g-4">
                    <c:forEach var="p" items="${productos}">
                        <div class="col-sm-6 col-md-4 col-lg-3">
                            <div class="card card-producto h-100">

                                <!-- Imagen desde API -->
                                <img src="http://localhost:8083/api/productos/${p.idProducto}/imagen"
                                     alt="Imagen ${p.nombre}"
                                     onerror="this.src='https://via.placeholder.com/400x220?text=Producto';">

                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title mb-2">${p.nombre}</h5>

                                    <p class="card-text text-white-50 mb-3"
                                       style="font-size:.85rem;">
                                        ${p.descripcion}
                                    </p>

                                    <div class="mt-auto text-end">
                                        <span class="badge-precio">
                                            ${p.precio} €
                                        </span>
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
