<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mi carrito · Máxima Carga</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <style>
        body {
            background-color: #020617;
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
        .card-carrito {
            border-radius: 1rem;
            background: #0f172a;
            color: #e5e7eb;
            border: 1px solid rgba(148,163,184,.4);
            box-shadow: 0 18px 45px rgba(15,23,42,.5);
        }
        .table thead {
            background-color: #111827;
            color: #f9fafb;
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
        .img-mini {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: .5rem;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

<!-- BARRA SUPERIOR -->
<div class="top-bar">
    <div class="container-xxl py-2 d-flex justify-content-between align-items-center">
        <span class="fw-semibold text-uppercase">
            Máxima Carga · Carrito de compra
        </span>
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/catalogo"
               class="btn btn-sm btn-outline-light">
                ← Volver al catálogo
            </a>
            <a href="${pageContext.request.contextPath}/"
               class="btn btn-sm btn-outline-light">
                Inicio
            </a>
        </div>
    </div>
</div>

<!-- CONTENIDO -->
<main class="page-wrapper flex-grow-1">
    <div class="container-xxl">
        <div class="card card-carrito">
            <div class="card-body">

                <h3 class="fw-bold mb-3">Mi carrito</h3>

                <!-- Mensajes -->
                <c:if test="${not empty ok}">
                    <div class="alert alert-success">${ok}</div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <!-- Mantengo tu errorCarrito por si lo sigues usando -->
                <c:if test="${not empty errorCarrito}">
                    <div class="alert alert-danger">${errorCarrito}</div>
                </c:if>

                <c:choose>
                    <c:when test="${empty lineasCarrito}">
                        <p class="text-white-50 mb-0">
                            Tu carrito está vacío. Ve al catálogo para añadir productos.
                        </p>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table align-middle mb-0">
                                <thead>
                                <tr>
                                    <th>Imagen</th>
                                    <th>Producto</th>
                                    <th class="text-center">Cantidad</th>
                                    <th class="text-end">Precio</th>
                                    <th class="text-end">Subtotal</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="linea" items="${lineasCarrito}">
                                    <tr>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty linea.producto.imagenProducto}">
                                                    <img class="img-mini"
                                                         src="data:image/jpeg;base64,${linea.producto.imagenProducto}"
                                                         alt="${linea.producto.nombre}">
                                                </c:when>
                                                <c:otherwise>
                                                    <img class="img-mini"
                                                         src="https://via.placeholder.com/60?text=IMG"
                                                         alt="Sin imagen">
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${linea.producto.nombre}</td>
                                        <td class="text-center">${linea.cantidad}</td>
                                        <td class="text-end">
                                            ${linea.producto.precio} €
                                        </td>
                                        <td class="text-end">
                                            ${linea.subtotal} €
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <th colspan="4" class="text-end">Total:</th>
                                    <th class="text-end">${totalCarrito} €</th>
                                </tr>
                                </tfoot>
                            </table>
                        </div>

                        <div class="mt-3 d-flex justify-content-end">
                            <!-- BOTÓN REAL DE COMPRA -->
                            <form method="post" action="${pageContext.request.contextPath}/carrito/comprar">
                                <button class="btn btn-main" type="submit">
                                    Finalizar compra
                                </button>
                            </form>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
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
</body>
</html>
