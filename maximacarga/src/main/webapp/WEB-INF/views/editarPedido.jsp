<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Pedido</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-dark text-light">

<div class="container mt-5">

    <div class="card bg-secondary shadow-lg p-4">

        <h2 class="mb-4 text-warning">Modificar Estado del Pedido</h2>

        <form:form method="post" modelAttribute="pedido">

            <!-- ID SOLO LECTURA -->
            <div class="mb-3">
                <label class="form-label">ID Pedido</label>
                <form:input path="id" class="form-control" readonly="true"/>
            </div>

            <!-- ESTADO -->
            <div class="mb-3">
                <label class="form-label">Estado</label>

                <form:select path="estado" class="form-control">

                    <form:option value="EN_PREPARACION">EN_PREPARACION</form:option>
                    <form:option value="ENVIADO">ENVIADO</form:option>
                    <form:option value="ENTREGADO">ENTREGADO</form:option>
                    <form:option value="CANCELADO">CANCELADO</form:option>

                </form:select>
            </div>

            <!-- BOTONES -->
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-warning">
                    Guardar cambios
                </button>

                <a href="${pageContext.request.contextPath}/pedidos/listar"
                   class="btn btn-outline-light">
                    Cancelar
                </a>
            </div>

        </form:form>

    </div>

</div>

</body>
</html>
