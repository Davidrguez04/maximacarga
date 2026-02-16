<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ayuda y Soporte · Máxima Carga</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>

    <style>
        body {
            background: radial-gradient(circle at top left,#f97316 0,#111827 40%,#020617 100%);
            color: #f3f4f6;
            font-family: 'Segoe UI', sans-serif;
            padding-top: 4rem;
            min-height: 100vh;
        }
        .card-help {
            border-radius: 1rem;
            background: #f9fafb;
            color: #111827;
            padding: 2rem;
            box-shadow: 0 14px 35px rgba(0,0,0,.35);
        }
        .help-icon {
            font-size: 2.2rem;
            color: #f97316;
        }
    </style>
</head>

<body>

<div class="container-lg">

    <div class="text-center mb-5">
        <h1 class="fw-bold">Centro de Ayuda</h1>
        <p class="lead text-light-50">
            ¿Necesitas ayuda? Estamos aquí para ayudarte con tu cuenta, pedidos o productos.
        </p>
    </div>

    <div class="row g-4 justify-content-center">

        <!-- 📞 Teléfono -->
        <div class="col-md-4">
            <div class="card-help text-center">
                <i class="fas fa-phone help-icon mb-3"></i>
                <h5 class="fw-bold">Teléfono de soporte</h5>
                <p class="mb-1">+34 600 123 456</p>
                <small>Horario: L-V 09:00 - 20:00</small>
            </div>
        </div>

        <!-- 📧 Correo -->
        <div class="col-md-4">
            <div class="card-help text-center">
                <i class="fas fa-envelope help-icon mb-3"></i>
                <h5 class="fw-bold">Correo de contacto</h5>
                <p class="mb-1">soporte@maximacarga.com</p>
                <small>Respondemos en menos de 24h</small>
            </div>
        </div>

        <!-- 📬 Soporte rápido -->
        <div class="col-md-4">
            <div class="card-help text-center">
                <i class="fas fa-headset help-icon mb-3"></i>
                <h5 class="fw-bold">Asistencia rápida</h5>
                <p>¿Problema urgente?</p>
                <a href="mailto:soporte@maximacarga.com" class="btn btn-warning">
                    Enviar mensaje rápido
                </a>
            </div>
        </div>

    </div>

    <!-- Botón volver -->
    <div class="text-center mt-5">
        <a href="${pageContext.request.contextPath}/"
           class="btn btn-outline-light">
            <i class="fas fa-arrow-left me-1"></i> Volver al panel
        </a>
    </div>

</div>

</body>
</html>