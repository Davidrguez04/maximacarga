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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Administrador - Máxima Carga</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body { background:#0b1020; color:#e5e7eb; font-family: "Segoe UI", system-ui, -apple-system, Arial, sans-serif; }
        .topbar { background:#070b14; border-bottom: 1px solid rgba(255,255,255,.08); }
        .topbar .btn { border-color: rgba(255,255,255,.35); }

        .hero-wrap {
            min-height: calc(100vh - 76px);
            padding: 2.5rem 0;
        }

        .bg-hero {
            background:
                radial-gradient(1200px 600px at 15% 30%, rgba(249,115,22,.45), transparent 60%),
                radial-gradient(900px 500px at 85% 20%, rgba(56,189,248,.25), transparent 55%),
                linear-gradient(180deg, #0b1020, #060814);
            border-radius: 1.5rem;
            padding: 2.25rem;
        }

        .pill {
            display:inline-flex; align-items:center; gap:.5rem;
            background: rgba(255,255,255,.08);
            border: 1px solid rgba(255,255,255,.12);
            border-radius: 999px;
            padding: .35rem .75rem;
            font-size: .8rem;
        }

        .card-soft {
            background: rgba(255,255,255,.06);
            border: 1px solid rgba(255,255,255,.12);
            border-radius: 1.25rem;
            color:#e5e7eb;
            box-shadow: 0 18px 55px rgba(0,0,0,.35);
        }

        .card-soft .card-title { color:#f9fafb; font-weight: 700; }
        .card-soft small { color: rgba(229,231,235,.75); }

        .btn-outline-light { border-color: rgba(255,255,255,.35); }
        .btn-ghost {
            background: rgba(255,255,255,.08);
            border: 1px solid rgba(255,255,255,.12);
            color:#f9fafb;
        }
        .btn-ghost:hover { filter: brightness(1.08); }

        .btn-main {
            background: linear-gradient(90deg, #f97316, #ea580c);
            border: none;
            color: #111827;
            font-weight: 700;
        }

        .footer { color: rgba(229,231,235,.6); border-top: 1px solid rgba(255,255,255,.08); background:#070b14; }
    </style>
</head>

<body class="d-flex flex-column min-vh-100">

<!-- TOPBAR -->
<header class="topbar py-3">
    <div class="container-xxl d-flex align-items-center justify-content-between">
        <div class="d-flex align-items-center gap-2">
            <span class="fw-bold text-white">PANEL ADMINISTRADOR</span>
            <span class="text-white-50">| Área interna de Máxima Carga</span>
        </div>

        <div class="d-flex align-items-center gap-2">
            <span class="text-white-50 small">
                Conectado como <strong class="text-white">${sessionScope.usuario.nombreUsuario}</strong>
            </span>

            <a href="${pageContext.request.contextPath}/"
               class="btn btn-sm btn-outline-light">
                Ir a la web
            </a>

            <a href="${pageContext.request.contextPath}/cerrarSesion"
               class="btn btn-sm btn-outline-light">
                Cerrar sesión
            </a>
        </div>
    </div>
</header>

<main class="hero-wrap flex-grow-1">
    <div class="container-xxl">
        <div class="bg-hero">
            <div class="row g-4 align-items-start">
                <!-- LEFT HERO -->
                <div class="col-12 col-lg-6">
                    <div class="pill mb-3">
                        🔒 <span>ÁREA PRIVADA</span>
                    </div>

                    <h1 class="display-5 fw-bold text-white mb-2">
                        Bienvenido,<br>
                        <span style="color:#f97316;">${sessionScope.usuario.nombreUsuario}</span>
                    </h1>

                    <p class="text-white-50 mb-4" style="max-width: 520px;">
                        Gestiona usuarios, pedidos, productos y tu cuenta con el estilo visual de Máxima Carga.
                    </p>

                    <div class="d-flex flex-wrap gap-2">
                        <a href="${pageContext.request.contextPath}/usuarios/modificar?id=${sessionScope.usuario.idUsuario}"
                           class="btn btn-main">
                            Modificar mis datos
                        </a>

                        <a href="${pageContext.request.contextPath}/"
                           class="btn btn-ghost">
                            ← Volver a la página principal
                        </a>
                    </div>
                </div>

                <!-- RIGHT CARDS -->
                <div class="col-12 col-lg-6">
                    <div class="row g-3">
                        <!-- USUARIOS -->
                        <div class="col-12 col-md-6">
                            <div class="card card-soft h-100">
                                <div class="card-body">
                                    <div class="d-flex align-items-center gap-2 mb-2">
                                        <span class="badge rounded-pill text-bg-dark">👥</span>
                                        <small>Gestión</small>
                                    </div>
                                    <h5 class="card-title mb-2">Usuarios</h5>
                                    <p class="mb-3 text-white-50">Consulta, modifica o elimina usuarios.</p>

                                    <a href="${pageContext.request.contextPath}/usuarios/listar"
                                       class="btn btn-sm btn-outline-light">
                                        Ver / gestionar usuarios
                                    </a>
                                </div>
                            </div>
                        </div>

                        <!-- PEDIDOS -->
                        <div class="col-12 col-md-6">
                            <div class="card card-soft h-100">
                                <div class="card-body">
                                    <div class="d-flex align-items-center gap-2 mb-2">
                                        <span class="badge rounded-pill text-bg-dark">🧾</span>
                                        <small>Operativa</small>
                                    </div>
                                    <h5 class="card-title mb-2">Pedidos</h5>
                                    <p class="mb-3 text-white-50">Revisa el histórico y el estado de los pedidos.</p>

                                    <a href="${pageContext.request.contextPath}/pedidos/listar"
                                       class="btn btn-sm btn-outline-light">
                                        Ver / gestionar pedidos
                                    </a>
                                </div>
                            </div>
                        </div>

                        <!-- PRODUCTOS (NUEVA TARJETA) -->
                        <div class="col-12">
                            <div class="card card-soft">
                                <div class="card-body d-flex flex-column flex-md-row align-items-start align-items-md-center justify-content-between gap-3">
                                    <div>
                                        <div class="d-flex align-items-center gap-2 mb-2">
                                            <span class="badge rounded-pill text-bg-dark">🏋️</span>
                                            <small>Catálogo</small>
                                        </div>
                                        <h5 class="card-title mb-1">Productos</h5>
                                        <p class="mb-0 text-white-50">Añade nuevos productos o revisa el catálogo existente.</p>
                                    </div>

                                    <div class="d-flex gap-2 flex-wrap">
                                        <!-- CAMBIA /productos/agregar si tu ruta es otra -->
                                        <a href="${pageContext.request.contextPath}/productos/productoNuevo"
                                           class="btn btn-sm btn-main">
                                            Agregar producto
                                        </a>

                                        <a href="${pageContext.request.contextPath}/productos/listar"
                                           class="btn btn-sm btn-outline-light">
                                            Ver productos
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- CENTRO DE CONTROL -->
                        <div class="col-12">
                            <div class="card card-soft">
                                <div class="card-body d-flex align-items-center justify-content-between flex-wrap gap-2">
                                    <div>
                                        <small class="text-white-50">Atajo rápido</small>
                                        <h5 class="card-title mb-0">Centro de control</h5>
                                        <p class="mb-0 text-white-50">Accede rápidamente a herramientas internas.</p>
                                    </div>

                                    <a href="${pageContext.request.contextPath}/ayuda" class="btn btn-sm btn-ghost">Ayuda / Soporte</a>
                                </div>
                            </div>
                        </div>

                    </div><!-- /row -->
                </div>
            </div><!-- /row -->
        </div><!-- /bg-hero -->
    </div>
</main>

<footer class="footer py-3 mt-auto">
    <div class="container-xxl d-flex justify-content-between align-items-center">
        <span>© 2025 Máxima Carga</span>
        <strong class="text-white">MÁXIMACARGA</strong>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
