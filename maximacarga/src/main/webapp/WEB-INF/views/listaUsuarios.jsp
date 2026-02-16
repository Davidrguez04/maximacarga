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
    <title>Gestión de usuarios - Máxima Carga</title>

    <!-- Bootstrap 5 -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
        crossorigin="anonymous">

    <!-- Iconos -->
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
        .card-users {
            border-radius: 1rem;
            border: none;
            background: #f9fafb;
            color: #111827;
            box-shadow: 0 18px 45px rgba(15,23,42,.18);
        }
        .card-users .card-title {
            font-weight: 700;
        }
        .table thead {
            background-color: #111827;
            color: #f9fafb;
        }
        .badge-rol {
            font-size: .75rem;
        }
        .footer-admin {
            background-color: #020617;
            color: #9ca3af;
            font-size: .85rem;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

<!-- Barra superior (igual estilo admin.jsp) -->
<div class="top-bar">
    <div class="container-xxl">
        <div class="d-flex flex-wrap justify-content-between align-items-center py-2 gap-2">
            <div class="d-flex align-items-center gap-2">
                <span class="fw-semibold text-uppercase">Panel administrador</span>
                <span class="text-white-50 d-none d-sm-inline">| Gestión de usuarios</span>
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
        <div class="card card-users">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                    <div>
                        <h5 class="card-title mb-1">
                            <i class="fas fa-users me-2"></i> Usuarios registrados
                        </h5>
                        <p class="mb-0 text-muted" style="font-size:.9rem;">
                            Aquí puedes ver, modificar o eliminar usuarios de la base de datos.
                        </p>
                    </div>
                    <a href="${pageContext.request.contextPath}/"
                       class="btn btn-outline-dark btn-sm">
                        <i class="fas fa-home me-1"></i> Volver a la web
                    </a>
                </div>

                <div class="table-responsive">
                    <table class="table align-middle mb-0">
                        <thead>
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Nombre</th>
                            <th scope="col">Apellidos</th>
                            <th scope="col">Correo</th>
                            <th scope="col">Móvil</th>
                            <th scope="col">Tipo</th>
                            <th scope="col" class="text-end">Acciones</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="u" items="${usuarios}">
                            <tr>
                                <td>${u.idUsuario}</td>
                                <td>${u.nombreUsuario}</td>
                                <td>${u.apellidosUsuario}</td>
                                <td>${u.correoElectronico}</td>
                                <td>${u.movil}</td>
                                <td>
                                    <span class="badge bg-dark badge-rol">
                                        ${u.tipoUsuario}
                                    </span>
                                </td>
                                <td class="text-end">
                                    <!-- Botón MODIFICAR -->
                                    <a href="${pageContext.request.contextPath}/usuarios/modificar?id=${u.idUsuario}"
                                       class="btn btn-sm btn-outline-primary me-2">
                                        <i class="fas fa-edit"></i> Modificar
                                    </a>

                                    <!-- Botón ELIMINAR -->
                                    <form action="${pageContext.request.contextPath}/usuarios/eliminar"
                                          method="get"
                                          class="d-inline"
                                          onsubmit="return confirm('¿Seguro que deseas eliminar este usuario?');">
                                        <input type="hidden" name="id" value="${u.idUsuario}">
                                        <button type="submit" class="btn btn-sm btn-outline-danger">
                                            <i class="fas fa-trash-alt"></i> Eliminar
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty usuarios}">
                            <tr>
                                <td colspan="7" class="text-center text-muted py-4">
                                    No hay usuarios para mostrar.
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
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none"
                 xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                <path d="M12 21c4.97 0 9-4.03 9-9S16.97 3 12 3 3 7.03 3 12s4.03 9 9 9Z"
                      stroke="currentColor" stroke-width="1.5"/>
                <path d="M7 13c2-4 5-5 10-3-2 4-5 5-10 3Z" stroke="currentColor" stroke-width="1.5"/>
            </svg>
            <strong class="text-white">MÁXIMACARGA</strong>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>