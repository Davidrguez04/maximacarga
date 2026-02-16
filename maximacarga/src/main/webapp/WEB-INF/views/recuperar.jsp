<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Recuperar contraseña · Máxima Carga</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            min-height: 100vh;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            background: radial-gradient(circle at top, #1f2937 0, #020617 55%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #e5e7eb;
        }

        .card-recuperar {
            width: 100%;
            max-width: 420px;
            background: rgba(15, 23, 42, 0.95);
            border-radius: 1.3rem;
            padding: 2.5rem 2.3rem;
            box-shadow: 0 25px 60px rgba(0,0,0,0.6);
            backdrop-filter: blur(10px);
            animation: fadeIn 0.4s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .logo-title {
            text-align: center;
            font-weight: 700;
            letter-spacing: 0.1em;
            font-size: 0.85rem;
            color: #9ca3af;
            margin-bottom: 0.8rem;
        }

        h2 {
            text-align: center;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .subtitle {
            text-align: center;
            font-size: 0.9rem;
            color: #9ca3af;
            margin-bottom: 1.8rem;
        }

        .form-label {
            font-size: 0.85rem;
            color: #d1d5db;
            margin-bottom: 0.4rem;
        }

        .input-wrapper {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            border-radius: 0.8rem;
            border: 1px solid #4b5563;
            padding: 0.55rem 0.8rem;
            background: #020617;
            transition: 0.2s ease;
        }

        .input-wrapper:focus-within {
            border-color: #f59e0b;
            box-shadow: 0 0 0 1px rgba(245,158,11,0.5);
        }

        .input-wrapper input {
            border: none;
            background: transparent;
            outline: none;
            width: 100%;
            color: #e5e7eb;
            font-size: 0.95rem;
        }

        .input-wrapper input::placeholder {
            color: #6b7280;
        }

        .btn-main {
            width: 100%;
            background: #f59e0b;
            border: none;
            padding: 0.8rem;
            border-radius: 0.8rem;
            font-weight: 700;
            font-size: 1rem;
            color: #111827;
            margin-top: 1.3rem;
            transition: 0.2s ease;
        }

        .btn-main:hover {
            background: #fbbf24;
            transform: translateY(-1px);
        }

        .volver-link {
            text-align: center;
            margin-top: 1.5rem;
            font-size: 0.9rem;
        }

        .volver-link a {
            color: #fbbf24;
            text-decoration: none;
        }

        .volver-link a:hover {
            text-decoration: underline;
        }

        .alert {
            font-size: 0.85rem;
            border-radius: 0.6rem;
        }
    </style>
</head>
<body>

<div class="card-recuperar">

    <div class="logo-title">MÁXIMA CARGA</div>

    <h2>¿Olvidaste tu contraseña?</h2>
    <p class="subtitle">
        Introduce tu correo y te enviaremos instrucciones para restablecerla.
    </p>

    <c:if test="${not empty mensaje}">
        <div class="alert alert-success">
            ${mensaje}
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            ${error}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/recuperar" method="post">

        <label class="form-label">Correo electrónico</label>
        <div class="input-wrapper">
            📧
            <input type="email" name="correoElectronico"
                   placeholder="tucorreo@ejemplo.com" required>
        </div>

        <button type="submit" class="btn-main">
            Enviar instrucciones
        </button>

    </form>

    <div class="volver-link">
        <a href="${pageContext.request.contextPath}/login">
            ← Volver al inicio de sesión
        </a>
    </div>

</div>

</body>
</html>
