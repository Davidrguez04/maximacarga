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
    <title>Modificar perfil · Máxima Carga</title>

    <!-- Bootstrap -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
        crossorigin="anonymous">

    <!-- (Opcional) tu CSS propio si tienes uno -->
    <!-- <link rel="stylesheet" href="<c:url value='/css/estilos.css' />"> -->

    <style>
        body { min-height: 100vh; display:flex; flex-direction:column; background:#f3f4f6; }
        .app-header { background:#0b0f1a; }
        .brand { color:#fff; text-decoration:none; font-weight:700; letter-spacing:.5px; }
        .content { flex:1; padding:2rem 0; }
        .card-panel {
            border:0;
            border-radius:1rem;
            padding:2rem;
            background:#ffffff;
            box-shadow:0 10px 25px rgba(0,0,0,.08);
        }
        footer { border-top:1px solid rgba(0,0,0,.06); background:#f9fafb; }
    </style>
</head>
<body>

<!-- Cabecera -->
<header class="app-header py-3">
    <div class="container-xxl d-flex align-items-center justify-content-between">
        <a href="${pageContext.request.contextPath}/" class="brand h4 mb-0">Máxima Carga</a>
        <nav class="d-flex align-items-center gap-3">
            <a href="${pageContext.request.contextPath}/" class="btn btn-sm btn-outline-light">Inicio</a>
            <a href="${pageContext.request.contextPath}/cerrarSesion" class="btn btn-sm btn-outline-light">
                Cerrar sesión
            </a>
        </nav>
    </div>
</header>

<!-- Contenido principal -->
<main class="content">
    <div class="container-xxl">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card-panel">

                    <h2 class="mb-4 text-center">Modificar perfil</h2>

                    <!-- Mensajes -->
                    <c:if test="${not empty mensaje}">
                        <div class="alert alert-success">${mensaje}</div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                   
                    <form action="${pageContext.request.contextPath}/modificarUsuario" method="POST">

                        <!-- id del usuario -->
                        <input type="hidden" name="id"
                               value="${usuario.idUsuario}" />

                        <div class="mb-3">
                            <label for="nombreUsuario" class="form-label">Nombre:</label>
                            <input type="text"
                                   class="form-control"
                                   id="nombreUsuario"
                                   name="nombreUsuario"
                                   value="${usuario.nombreUsuario}"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label for="apellidosUsuario" class="form-label">Apellidos:</label>
                            <input type="text"
                                   class="form-control"
                                   id="apellidosUsuario"
                                   name="apellidosUsuario"
                                   value="${usuario.apellidosUsuario}"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label for="movil" class="form-label">Móvil:</label>
                            <input type="tel"
                                   class="form-control"
                                   id="movil"
                                   name="movil"
                                   value="${usuario.movil}"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label for="correoElectronico" class="form-label">Correo electrónico:</label>
                            <input type="email"
                                   class="form-control"
                                   id="correoElectronico"
                                   name="correoElectronico"
                                   value="${usuario.correoElectronico}"
                                   readonly>
                        </div>

                        <div class="mb-3">
                            <label for="fchNacUsu" class="form-label">Fecha de nacimiento:</label>
                            <input type="date"
                                   class="form-control"
                                   id="fchNacUsu"
                                   name="fchNacUsu"
                                   value="${usuario.fchNacUsu}">
                        </div>

                        <hr class="my-4">

                        <div class="mb-3">
                            <label for="nuevaContrasenia" class="form-label">Nueva contraseña (opcional):</label>
                            <input type="password"
                                   class="form-control"
                                   id="nuevaContrasenia"
                                   name="nuevaContrasenia">
                        </div>

                        <div class="mb-3">
                            <label for="repNuevaContrasenia" class="form-label">Confirmar nueva contraseña:</label>
                            <input type="password"
                                   class="form-control"
                                   id="repNuevaContrasenia"
                                   name="repNuevaContrasenia">
                        </div>

                        <div class="mb-3">
                            <label for="contraseniaActual" class="form-label">
                                Contraseña actual (obligatoria si cambias la contraseña):
                            </label>
                            <input type="password"
                                   class="form-control"
                                   id="contraseniaActual"
                                   name="contraseniaActual">
                        </div>

                        <button type="submit" class="btn btn-warning w-100">
                            Guardar cambios
                        </button>
                    </form>

                    <!-- Botón de volver -->
                    <div class="text-center mt-3">
                        <c:choose>
                            <c:when test="${sessionScope.usuario.tipoUsuario eq 'admin'}">
                                <a href="${pageContext.request.contextPath}/admin"
                                   class="btn btn-outline-secondary">
                                    Volver al panel
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/usuario"
                                   class="btn btn-outline-secondary">
                                    Volver a mi área
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>

                </div>
            </div>
        </div>
    </div>
</main>

<!-- Footer -->
<footer class="text-center py-3 mt-auto">
    <div class="container-xxl text-muted small">
        © <script>document.write(new Date().getFullYear())</script> Máxima Carga
    </div>
</footer>

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
    crossorigin="anonymous"></script>
</body>
</html>
