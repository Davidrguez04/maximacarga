<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Registro | Máxima Carga</title>

  <!-- Bootstrap 5 -->
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
    crossorigin="anonymous">

  <style>
    body { font-family: 'Segoe UI', sans-serif; }
    header.hero {
      min-height: 40vh; position: relative; overflow: hidden;
      background: #000;
    }
    .hero-img {
      position: absolute; inset: 0; width: 100%; height: 100%; object-fit: cover; opacity: .45;
    }
    .hero-overlay { position: absolute; inset: 0;
      background: radial-gradient(ellipse at 30% 20%, rgba(246,163,58,.35), transparent 60%);
    }
    .hero h1 { position: relative; z-index: 1; color: #fff; }
    .badge-outline {
      -webkit-text-stroke: 1px #f6a33a; color: transparent; text-transform: uppercase; letter-spacing: .5px;
    }
    .card { border: none; box-shadow: 0 8px 30px rgba(0,0,0,.08); }
    .form-text { opacity: .85; }
    .pw-meter { height: .4rem; background: #e9ecef; border-radius: .25rem; overflow: hidden; }
    .pw-meter > div { height: 100%; width: 0; transition: width .25s ease; }
    footer { margin-top: auto; }
  </style>
</head>
<body class="d-flex flex-column min-vvh-100">

  <!-- Barra negra superior -->
  <div class="bg-black text-white small">
    <div class="container-xxl">
      <div class="d-flex justify-content-end align-items-center py-2 gap-2">
        <a class="btn btn-sm btn-outline-light" href="${pageContext.request.contextPath}/login">Iniciar sesión</a>
        <a class="btn btn-sm btn-warning text-dark" href="${pageContext.request.contextPath}/registro">Registrarse</a>
        <a class="btn btn-sm btn-outline-light" href="${pageContext.request.contextPath}/help">Ayuda</a>
        <a class="btn btn-sm btn-outline-light" href="${pageContext.request.contextPath}/contact">Contacto</a>
      </div>
    </div>
  </div>

  <!-- Hero -->
  <header class="hero d-flex align-items-center">
    <!--  <img class="hero-img" src="${pageContext.request.contextPath}/img/hero.jpg" alt="Fondo registro">-->
    <div class="hero-overlay"></div>
    <div class="container-xxl">
      <div class="col-12 col-lg-7">
        <h1 class="display-6 fw-bold lh-sm">
          Crea tu cuenta <span class="badge-outline">Máxima Carga</span>
        </h1>
        <p class="lead text-white-50 mb-0">Únete y gestiona tus pedidos y equipo de entrenamiento.</p>
      </div>
    </div>
  </header>

  <!-- Formulario -->
  <main class="flex-grow-1 py-5">
    <div class="container-xxl">
      <div class="row justify-content-center">
        <div class="col-12 col-lg-8 col-xl-7">
          <div class="card">
            <div class="card-body p-4 p-md-5">
              <h2 class="h4 mb-4">Datos de registro</h2>

              <!-- Importante: ajusta la acción al endpoint POST de tu UsuarioControlador -->
              <!-- Ruta para enviar los datos al controlador -->
              <form action="${pageContext.request.contextPath}/registrarUsuario" method="post" novalidate>
                <!-- ID (clave primaria) 
                <div class="mb-3">
                  <label for="id" class="form-label">ID (clave primaria)</label>
                  <input type="text" class="form-control" id="id" name="id"
                         placeholder="Ej.: UUID o código interno" aria-describedby="idHelp">
                  <div id="idHelp" class="form-text">
                    Si lo dejas vacío, el sistema puede generarlo automáticamente (según tu backend).
                  </div>
                </div> -->

                <!-- Nombre completo (máx 50) -->
                <div class="mb-3">
                  <label for="nombre" class="form-label">Nombre </label>
                  <input type="text" class="form-control" id="nombre" name="nombre"
                         maxlength="50" required placeholder="Nombre">
                  <div class="form-text">Máximo 50 caracteres.</div>
                </div>
                <div class="mb-3">
                  <label for="apellido1" class="form-label">Primer Apellido </label>
                  <input type="text" class="form-control" id="apellido1" name="apellido1"
                         maxlength="50" required placeholder="Primer Apellido">
                  <div class="form-text">Máximo 50 caracteres.</div>
                </div>
                
                <div class="mb-3">
                  <label for="apellido2" class="form-label">Segundo Apellido </label>
                  <input type="text" class="form-control" id="apellido2" name="apellido2"
                         maxlength="50" required placeholder="Segundo Apellido">
                  <div class="form-text">Máximo 50 caracteres.</div>
                </div>
                <div class="mb-3">
                  <label for="fechaNac" class="form-label">Fecha de Nacimiento </label>
                  <input type="date" class="form-control" id="fechaNac" name="fechaNac"
                         maxlength="50" required placeholder="Fecha Nacimiento">
                  <div class="form-text">Máximo 50 caracteres.</div>
                </div>
                

                <!-- Móvil -->
                <div class="mb-3">
                  <label for="movil" class="form-label">Móvil</label>
                  <input type="tel" class="form-control" id="movil" name="movil"
                         pattern="\\+?\\d{9,15}" required placeholder="Ej.: +34600111222">
                  <div class="form-text">Introduce entre 9 y 15 dígitos (puede incluir prefijo +).</div>
                </div>

                <!-- Correo electrónico (máx 50) -->
                <div class="mb-3">
                  <label for="email" class="form-label">Correo electrónico</label>
                  <input type="email" class="form-control" id="email" name="email"
                         maxlength="50" required placeholder="tucorreo@dominio.com" autocomplete="email">
                  <div class="form-text">Máximo 50 caracteres.</div>
                </div>

                <!-- Tipo de usuario (rol) -->
                <div class="mb-3">
                  <label for="rol" class="form-label">Tipo de usuario</label>
                  <select class="form-select" id="rol" name="rol" required>
                    <option value="" selected disabled>Selecciona un rol…</option>
                    <option value="USUARIO">Usuario normal</option>
                    <option value="ADMIN">Administrador</option>
                  </select>
                </div>

                <!-- Contraseña -->
                <div class="mb-2">
                  <label for="password" class="form-label">Contraseña</label>
                  <div class="input-group">
                    <input type="password" class="form-control" id="password" name="password"
                           required minlength="8" autocomplete="new-password" aria-describedby="pwHelp">
                    <button class="btn btn-outline-secondary" type="button" id="togglePw">Mostrar</button>
                  </div>
                  <div class="form-text" id="pwHelp">
                    La contraseña se almacena encriptada en base de datos. Mínimo 8 caracteres.
                  </div>
                </div>

                <!-- Medidor de fortaleza -->
                <div class="pw-meter mb-3" aria-hidden="true">
                  <div id="pwBar"></div>
                </div>

                <!-- Confirmación de contraseña -->
                <div class="mb-4">
                  <label for="password2" class="form-label">Confirmar contraseña</label>
                  <input type="password" class="form-control" id="password2" name="password2"
                         required minlength="8" autocomplete="new-password">
                  <div class="invalid-feedback" id="pwMatchFeedback">Las contraseñas no coinciden.</div>
                </div>

                <!-- Botones -->
                <div class="d-flex gap-2">
                  <button type="submit" class="btn btn-warning text-dark fw-semibold px-4">Crear cuenta</button>
                  <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary">Cancelar</a>
                </div>
              </form>

            </div>
          </div>

          <!-- Nota de privacidad -->
          <p class="text-muted small mt-3">
            Al registrarte aceptas nuestra política de privacidad y el tratamiento seguro de tus datos.
          </p>
        </div>
      </div>
    </div>
  </main>

  <!-- Footer -->
  <footer class="py-4 bg-dark text-white-50">
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

  <!-- Bootstrap JS -->
  <script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
    crossorigin="anonymous"></script>

  <!-- JS: mostrar/ocultar contraseña + validaciones rápidas -->
  <script>
    (function () {
      const pw = document.getElementById('password');
      const pw2 = document.getElementById('password2');
      const toggle = document.getElementById('togglePw');
      const bar = document.getElementById('pwBar');
      const feedback = document.getElementById('pwMatchFeedback');

      // Mostrar/ocultar
      toggle.addEventListener('click', () => {
        const type = pw.getAttribute('type') === 'password' ? 'text' : 'password';
        pw.setAttribute('type', type);
        pw2.setAttribute('type', type);
        toggle.textContent = type === 'password' ? 'Mostrar' : 'Ocultar';
      });

      // Medidor simple de fuerza
      function strength(s) {
        let score = 0;
        if (s.length >= 8) score++;
        if (/[A-Z]/.test(s)) score++;
        if (/[a-z]/.test(s)) score++;
        if (/[0-9]/.test(s)) score++;
        if (/[^A-Za-z0-9]/.test(s)) score++;
        return Math.min(score, 5);
      }
      function paintBar(val) {
        const pct = (val / 5) * 100;
        bar.style.width = pct + '%';
      }
      pw.addEventListener('input', () => paintBar(strength(pw.value)));

      // Coincidencia de contraseñas
      function checkMatch() {
        const ok = pw.value === pw2.value;
        if (!ok && pw2.value.length > 0) {
          pw2.classList.add('is-invalid');
          feedback.style.display = 'block';
        } else {
          pw2.classList.remove('is-invalid');
          feedback.style.display = 'none';
        }
        return ok;
      }
      pw.addEventListener('input', checkMatch);
      pw2.addEventListener('input', checkMatch);

      // Validación al enviar
      document.querySelector('form').addEventListener('submit', function (e) {
        if (!checkMatch()) e.preventDefault();
      });
    })();
  </script>
</body>
</html>