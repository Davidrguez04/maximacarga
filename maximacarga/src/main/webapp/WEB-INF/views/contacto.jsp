<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Contacto · Máxima Carga</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>

    <style>
        body {
            background: radial-gradient(circle at top left,#f97316 0,#111827 40%,#020617 100%);
            color: #f3f4f6;
            font-family: 'Segoe UI', sans-serif;
            padding-top: 3rem;
            min-height: 100vh;
        }

        .contact-card {
            background: rgba(255,255,255,0.95);
            border-radius: 1.2rem;
            padding: 2.5rem;
            box-shadow: 0 20px 45px rgba(0,0,0,.35);
            color: #111827;
            backdrop-filter: blur(6px);
        }

        .contact-icon {
            font-size: 2.5rem;
            color: #f97316;
        }

        .form-control, .form-control:focus {
            background: #f3f4f6;
            border: 1px solid #d1d5db;
            box-shadow: none;
        }

        .btn-contact {
            background: linear-gradient(90deg, #f97316, #ea580c);
            border: none;
            color: #fff;
            font-weight: 600;
        }

        .btn-contact:hover {
            filter: brightness(1.1);
        }
    </style>
</head>

<body>

<div class="container-lg">

    <div class="text-center mb-5">
        <h1 class="fw-bold display-5">Contacta con nosotros</h1>
        <p class="lead text-light-50">
            Estamos aquí para ayudarte con productos, pedidos o cualquier duda.
        </p>
    </div>

    <div class="row g-4 justify-content-center">

        <!-- 📞 TARJETA DE CONTACTO -->
        <div class="col-lg-4 col-md-6">
            <div class="contact-card text-center">
                <i class="fas fa-phone-alt contact-icon mb-3"></i>
                <h4 class="fw-bold">Teléfono</h4>
                <p class="mb-1 fs-5">+34 634 987 421</p>
                <small>Atención de L-V 09:00 - 20:00</small>
            </div>
        </div>

        <!-- 📧 TARJETA -->
        <div class="col-lg-4 col-md-6">
            <div class="contact-card text-center">
                <i class="fas fa-envelope contact-icon mb-3"></i>
                <h4 class="fw-bold">Correo electrónico</h4>
                <p class="mb-1 fs-5">contacto@maximacarga.com</p>
                <small>Respondemos en menos de 24h</small>
            </div>
        </div>

        <!-- 🏢 TARJETA -->
        <div class="col-lg-4 col-md-6">
            <div class="contact-card text-center">
                <i class="fas fa-map-marker-alt contact-icon mb-3"></i>
                <h4 class="fw-bold">Ubicación</h4>
                <p class="mb-1 fs-5">C/ Energía 24, Madrid</p>
                <small>Centro oficial de atención</small>
            </div>
        </div>

    </div>

    <!-- FORMULARIO MODERNO -->
    <div class="row justify-content-center mt-5">
        <div class="col-lg-8">
            <div class="contact-card">
                <h4 class="fw-bold mb-3"><i class="fas fa-paper-plane me-2"></i> Envíanos un mensaje</h4>

                <form>
                    <div class="mb-3">
                        <label class="form-label">Nombre</label>
                        <input type="text" class="form-control" placeholder="Tu nombre">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Correo electrónico</label>
                        <input type="email" class="form-control" placeholder="tucorreo@example.com">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Mensaje</label>
                        <textarea class="form-control" rows="4" placeholder="Escribe tu mensaje..."></textarea>
                    </div>

                    <button type="submit" class="btn btn-contact w-100">
                        Enviar mensaje
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- BOTÓN VOLVER -->
    <div class="text-center mt-4">
        <a href="${pageContext.request.contextPath}/"
           class="btn btn-outline-light">
            <i class="fas fa-arrow-left me-1"></i> Volver a inicio
        </a>
    </div>

</div>

</body>
</html>