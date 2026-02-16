<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Máxima Carga · Inicio</title>

    <!-- Bootstrap (si ya lo cargas en otro sitio puedes quitarlo) -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet"
    >

    <style>
        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            background: radial-gradient(circle at top, #1f2937 0, #020617 55%);
            color: #e5e7eb;
        }

        /* HEADER */
        .topbar {
            background: #000000;
            padding: 0.6rem 2rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .topbar-logo {
            font-weight: 700;
            color: #f9fafb;
            text-decoration: none;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            font-size: 0.9rem;
        }
        .topbar-nav {
            display: flex;
            gap: 0.6rem;
        }
        .topbar-btn {
            border-radius: 999px;
            border: 1px solid #4b5563;
            padding: 0.35rem 0.9rem;
            background: transparent;
            color: #f9fafb;
            font-size: 0.8rem;
            cursor: pointer;
        }
        .topbar-btn.highlight {
            background: #f59e0b;
            border-color: #f59e0b;
            color: #111827;
            font-weight: 600;
        }
        .topbar-btn:hover {
            background: #374151;
        }
        .topbar-btn.highlight:hover {
            background: #d97706;
        }

        /* HERO */
        .hero {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 3rem 2rem 4rem;
        }
        .hero-inner {
            max-width: 1100px;
            width: 100%;
            display: grid;
            grid-template-columns: minmax(0, 1.2fr) minmax(0, 1fr);
            gap: 3rem;
            align-items: center;
        }
        .hero-title {
            font-size: clamp(2.2rem, 4vw, 3.1rem);
            font-weight: 800;
            line-height: 1.1;
            text-transform: uppercase;
        }
        .hero-subtitle {
            margin-top: 0.7rem;
            font-size: 0.95rem;
            color: #9ca3af;
        }
        .hero-cta {
            margin-top: 1.8rem;
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }
        .hero-main-btn {
            background: #f59e0b;
            color: #111827;
            border-radius: 999px;
            border: none;
            padding: 0.9rem 1.8rem;
            font-weight: 700;
            font-size: 0.95rem;
            cursor: pointer;
        }
        .hero-main-btn:hover {
            background: #d97706;
        }
        .hero-secondary {
            font-size: 0.85rem;
            color: #9ca3af;
        }

        .hero-image {
            width: 100%;
            max-width: 420px;
            justify-self: center;
            border-radius: 1.5rem;
            overflow: hidden;
            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.7);
        }
        .hero-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        /* BLOQUE INFERIOR */
        .bottom-section {
            background: #f3f4f6;
            color: #111827;
            padding: 2.5rem 2rem 3rem;
        }

        /* MODAL LOGIN */
        .login-modal {
            position: fixed;
            inset: 0;
            z-index: 9999;
            display: none;              /* se muestra con la clase is-open */
            align-items: center;
            justify-content: center;
        }
        .login-modal.is-open {
            display: flex;
        }
        .login-backdrop {
            position: absolute;
            inset: 0;
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(4px);
        }
        .login-dialog {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 420px;
            background: #0b1120;
            border-radius: 1.2rem;
            padding: 2.2rem 2.4rem;
            box-shadow: 0 20px 45px rgba(0, 0, 0, 0.6);
            color: #e5e7eb;
        }
        .login-close {
            position: absolute;
            top: 0.7rem;
            right: 1rem;
            border: none;
            background: transparent;
            font-size: 1.4rem;
            cursor: pointer;
            line-height: 1;
            color: #9ca3af;
        }
        .login-close:hover { color: #f9fafb; }

        .login-header h2 {
            margin: 0 0 0.4rem 0;
            font-size: 1.6rem;
            font-weight: 700;
            text-align: left;
        }
        .login-subtitle {
            margin: 0 0 1.5rem 0;
            font-size: 0.9rem;
            color: #9ca3af;
        }

        .login-field {
            margin-bottom: 1rem;
        }
        .login-field label {
            display: block;
            font-size: 0.8rem;
            font-weight: 600;
            color: #d1d5db;
            margin-bottom: 0.35rem;
        }

        .login-input-wrapper {
            display: flex;
            align-items: center;
            gap: 0.4rem;
            border-radius: 0.75rem;
            border: 1px solid #4b5563;
            padding: 0.4rem 0.75rem;
            background: #020617;
            transition: border-color 0.15s ease, box-shadow 0.15s ease, background 0.15s ease;
        }
        .login-input-wrapper:focus-within {
            border-color: #f59e0b;
            box-shadow: 0 0 0 1px rgba(245, 158, 11, 0.5);
            background: #020617;
        }
        .login-input-wrapper input {
            border: none;
            background: transparent;
            outline: none;
            width: 100%;
            font-size: 0.95rem;
            color: #e5e7eb;
        }
        .login-input-wrapper input::placeholder {
            color: #6b7280;
        }

        .login-icon {
            color: #9ca3af;
            font-size: 1rem;
        }

        .login-extra {
            font-size: 0.8rem;
            color: #9ca3af;
        }

        .login-btn-primary {
            width: 100%;
            background: #f59e0b;
            border: none;
            padding: 0.75rem 1rem;
            color: #111827;
            font-size: 1rem;
            font-weight: 700;
            border-radius: 0.75rem;
            cursor: pointer;
            transition: background 0.15s ease, transform 0.05s ease;
        }
        .login-btn-primary:hover { background: #fbbf24; }
        .login-btn-primary:active { transform: scale(0.98); }

        .login-footer {
            text-align: center;
            margin-top: 1rem;
            color: #9ca3af;
            font-size: 0.9rem;
        }
        .login-link {
            color: #fbbf24;
            text-decoration: none;
        }
        .login-link:hover { text-decoration: underline; }

        footer {
            font-size: 0.8rem;
            color: #9ca3af;
            text-align: center;
            padding: 0.7rem 0;
            background: #020617;
        }
    </style>
</head>

<body>

<header class="topbar">
    <a href="${pageContext.request.contextPath}/" class="topbar-logo">MÁXIMA CARGA</a>

    <nav class="topbar-nav">
        <button class="topbar-btn" onclick="abrirLogin()">Iniciar sesión</button>
        <a href="${pageContext.request.contextPath}/registro" class="topbar-btn highlight">Registrarse</a>
        <a href="${pageContext.request.contextPath}/ayuda" class="topbar-btn">Ayuda</a>
        
    </nav>
</header>

<main class="hero">
    <div class="hero-inner">
        <section>
            <h1 class="hero-title">
                TU CUERPO NO ESPERA.<br>
                TU EQUIPO TAMPOCO DEBERÍA
            </h1>
            <p class="hero-subtitle">
                Equipamiento de gimnasio, accesorios y suplementos listos para acompañar tus entrenamientos.
                Descubre nuestro catálogo online y lleva tu rendimiento al siguiente nivel.
            </p>
            <div class="hero-cta">
                <a href="${pageContext.request.contextPath}/catalogoVista" class="hero-main-btn">
    Página principal
</a>
                <div class="hero-secondary">
                    Catálogo online con productos seleccionados para tu progreso.
                </div>
            </div>
        </section>

        <!--  <aside class="hero-image">
            
            <img src="${pageContext.request.contextPath}/img/portada-gym.jpg"
                 alt="Entrenando con suplemento y shaker">
        </aside>-->
    </div>
</main>

<section class="bottom-section">
    <div class="container">
        <div class="row g-3">

            <!-- MARCAS -->
            <div class="col-md-4">
                <div class="p-3 bg-white rounded-3 h-100 shadow-sm">
                    <h5>Marcas destacadas</h5>
                    <p class="mb-3">
                        Encuentra los mejores productos y accesorios de las marcas más reconocidas.
                    </p>

                    <a href="${pageContext.request.contextPath}/marcas"
                       class="btn btn-outline-dark btn-sm">
                        Ver marcas
                    </a>
                </div>
            </div>

            <!-- OFERTAS -->
            <div class="col-md-4">
                <div class="p-3 bg-white rounded-3 h-100 shadow-sm">
                    <h5>Ofertas</h5>
                    <p class="mb-3">
                        Promociones limitadas y combos exclusivos para tu entrenamiento.
                    </p>

                    <a href="${pageContext.request.contextPath}/ofertas"
                       class="btn btn-outline-dark btn-sm">
                        Ver ofertas
                    </a>
                </div>
            </div>

            <!-- SOPORTE -->
            <div class="col-md-4">
                <div class="p-3 bg-white rounded-3 h-100 shadow-sm">
                    <h5>Soporte</h5>
                    <p class="mb-3">
                        ¿Dudas con tu pedido o equipo? Estamos para ayudarte.
                    </p>

                    <a href="${pageContext.request.contextPath}/ayuda"
                       class="btn btn-outline-dark btn-sm">
                        Ir a ayuda
                    </a>
                </div>
            </div>

        </div>
    </div>
</section>


<!-- ============ MODAL LOGIN ============ -->
<div id="loginModal" class="login-modal">
    <div class="login-backdrop" onclick="cerrarLogin()"></div>

    <div class="login-dialog">
        <button type="button" class="login-close" onclick="cerrarLogin()">&times;</button>

        <div class="login-header">
            <h2>Iniciar sesión</h2>
            <p class="login-subtitle">Accede a tu cuenta para gestionar tus pedidos y entrenamientos.</p>
        </div>

        <c:if test="${not empty errorLogin}">
            <div class="alert alert-danger" style="font-size:0.9rem; padding:0.6rem;">
                ${errorLogin}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/iniciarSesion" method="post">
            <div class="login-field">
                <label for="email">Correo electrónico</label>
                <div class="login-input-wrapper">
                    <span class="login-icon">📧</span>
                    <input type="email" id="email" name="email"
                           placeholder="tucorreo@ejemplo.com" required>
                </div>
            </div>

            <div class="login-field">
                <label for="contrasenia">Contraseña</label>
                <div class="login-input-wrapper">
                    <span class="login-icon">🔒</span>
                    <input type="password" id="contrasenia" name="contrasenia"
                           placeholder="••••••••" required>
                </div>
            </div>

            <div class="login-extra d-flex justify-content-between align-items-center mb-3">
                <div>
                    <input type="checkbox" id="recordarme">
                    <label for="recordarme">Recuérdame</label>
                </div>
               <a href="${pageContext.request.contextPath}/recuperar"
                     class="login-link">
                      ¿Has olvidado tu contraseña?
               </a>
            </div>

            <button type="submit" class="login-btn-primary">
                Entrar
            </button>

            <div class="login-footer">
                <span>¿No tienes cuenta?</span>
                <a href="${pageContext.request.contextPath}/registro" class="login-link">
                    Regístrate
                </a>
            </div>
        </form>
    </div>
</div>

<footer>
    © <script>document.write(new Date().getFullYear())</script> Máxima Carga
</footer>

<script>
    function abrirLogin() {
        document.getElementById('loginModal').classList.add('is-open');
    }

    function cerrarLogin() {
        document.getElementById('loginModal').classList.remove('is-open');
    }

    // Si hay error de login, abrimos automáticamente el modal
    <%-- esto se ejecuta solo si errorLogin no es null --%>
    <c:if test="${not empty errorLogin}">
        window.addEventListener('load', function () {
            abrirLogin();
        });
    </c:if>
</script>

</body>
</html>