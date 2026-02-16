<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect(request.getContextPath() + "/");
        return;
    }
    response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<%@ page import="com.maximacarga.dtos.UsuarioDto" %>
<%
    UsuarioDto usu = (UsuarioDto) session.getAttribute("usuario");
%>

<!doctype html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Área de usuario • Máxima Carga</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">

<style>
body { min-height: 100vh; display:flex; flex-direction:column; }
.app-header { background:#0b0f1a; }
.brand { color:#fff; text-decoration:none; font-weight:700; }
.content { flex:1; padding:2rem 0; }
.card { border:0; border-radius:1rem; box-shadow:0 10px 25px rgba(0,0,0,.08); }
.table thead th { background:#0b0f1a; color:#fff; border:0; }
.badge-role { background:#f6a33a; }
.profile-img {
    width:150px;
    height:150px;
    object-fit:cover;
    border-radius:50%;
    border:4px solid #f6a33a;
}
</style>
</head>

<body>

<header class="app-header py-3">
<div class="container-xxl d-flex align-items-center justify-content-between">
<a href="${pageContext.request.contextPath}/" class="brand h4 mb-0">
Máxima Carga
</a>
<div class="d-flex align-items-center gap-3">
<span class="text-white-50 small">Área de Usuario</span>
<a href="${pageContext.request.contextPath}/catalogo"
   class="btn btn-sm btn-outline-light">Catálogo</a>
<a href="${pageContext.request.contextPath}/"
   class="btn btn-sm btn-outline-light">Inicio</a>
</div>
</div>
</header>

<main class="content">
<div class="container-xxl">
<div class="row g-4">

<!-- ALERTA BIENVENIDA -->
<div class="col-12">
<div class="alert alert-warning d-flex align-items-center justify-content-between">
<div>
<strong>Bienvenido,</strong>
<span class="ms-1"><%= usu.getNombreUsuario() %></span>
<span class="badge badge-role ms-2">
<%= usu.getTipoUsuario() != null ? usu.getTipoUsuario().toUpperCase() : "USUARIO" %>
</span>
</div>
<a class="btn btn-sm btn-outline-secondary"
   href="${pageContext.request.contextPath}/">Cerrar</a>
</div>
</div>

<!-- FOTO PERFIL -->
<div class="col-12 col-md-4">
<div class="card text-center">
<div class="card-body">

<h5 class="card-title mb-3">Foto de perfil</h5>

<img src="${pageContext.request.contextPath}/verFoto/<%= usu.getIdUsuario() %>"
     class="profile-img mb-3">

<form action="${pageContext.request.contextPath}/usuarios/subirFoto"
      method="post"
      enctype="multipart/form-data">

<div class="mb-3">
<input type="file"
       name="imagenPerfil"
       class="form-control"
       required>
</div>

<button type="submit"
        class="btn btn-primary btn-sm">
Cambiar foto
</button>

</form>

</div>
</div>
</div>

<!-- DATOS USUARIO -->
<div class="col-12 col-md-8">
<div class="card">
<div class="card-body p-4">

<h5 class="card-title mb-3">Tus datos</h5>

<div class="table-responsive">
<table class="table align-middle">
<thead>
<tr>
<th>Campo</th>
<th>Valor</th>
</tr>
</thead>
<tbody>

<tr>
<td>ID</td>
<td><%= usu.getIdUsuario() %></td>
</tr>

<tr>
<td>Nombre</td>
<td><%= usu.getNombreUsuario() %></td>
</tr>

<tr>
<td>Apellidos</td>
<td><%= usu.getApellidosUsuario() %></td>
</tr>

<tr>
<td>Correo electrónico</td>
<td><%= usu.getCorreoElectronico() %></td>
</tr>

<tr>
<td>Móvil</td>
<td><%= usu.getMovil() %></td>
</tr>

<tr>
<td>Fecha de nacimiento</td>
<td><%= usu.getFchNacUsu() != null ? usu.getFchNacUsu().toString() : "" %></td>
</tr>

<tr>
<td>Rol</td>
<td><%= usu.getTipoUsuario() %></td>
</tr>

<tr>
<td>Activo</td>
<td><%= (usu.getActivo() != null && usu.getActivo()) ? "Sí" : "No" %></td>
</tr>

</tbody>
</table>
</div>

<div class="mt-4">
<a href="${pageContext.request.contextPath}/"
   class="btn btn-outline-secondary">
Volver al inicio
</a>

<a href="${pageContext.request.contextPath}/usuarios/modificar"
   class="btn btn-primary ms-2">
Modificar datos
</a>

<a href="${pageContext.request.contextPath}/usuarios/misPedidos"
   class="btn btn-primary ms-2">
Mis pedidos
</a>
</div>

</div>
</div>
</div>

</div>
</div>
</main>

</body>
</html>
