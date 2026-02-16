<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Restablecer contraseña · Máxima Carga</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: radial-gradient(circle at top, #1f2937 0, #020617 55%);
            font-family: system-ui, sans-serif;
            color: #e5e7eb;
        }

        .card-reset {
            width: 100%;
            max-width: 450px;
            background: rgba(15, 23, 42, 0.95);
            border-radius: 1.4rem;
            padding: 2.5rem;
            box-shadow: 0 25px 60px rgba(0,0,0,0.6);
            backdrop-filter: blur(10px);
        }

        h2 {
            text-align: center;
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .input-wrapper {
            border-radius: 0.8rem;
            border: 1px solid #4b5563;
            padding: 0.6rem 0.9rem;
            background: #020617;
            margin-bottom: 1rem;
        }

        .input-wrapper input {
            width: 100%;
            border: none;
            background: transparent;
            outline: none;
            color: #fff;
        }

        .btn-main {
            width: 100%;
            background: #f59e0b;
            border: none;
            padding: 0.8rem;
            border-radius: 0.8rem;
            font-weight: 700;
            margin-top: 1rem;
        }

        .btn-main:hover {
            background: #fbbf24;
        }

        .alert {
            border-radius: 0.7rem;
        }
    </style>
</head>

<body>

<div class="card-reset">

    <h2>Nueva contraseña</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            ${error}
        </div>
    </c:if>

    <!-- 🔴 IMPORTANTE: enviamos el token oculto -->
    <form action="${pageContext.request.contextPath}/restablecerContrasenia" method="post">

        <input type="hidden" name="token" value="${token}" />

        <label>Nueva contraseña</label>
        <div class="input-wrapper">
            <input type="password" name="nuevaContrasenia" required />
        </div>

        <label>Repetir contraseña</label>
        <div class="input-wrapper">
            <!-- 🔴 ESTE NAME ES CLAVE -->
            <input type="password" name="repNuevaContrasenia" required />
        </div>

        <button type="submit" class="btn-main">
            Guardar nueva contraseña
        </button>

    </form>

</div>

</body>
</html>
