<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MÁXIMA CARGA - Activación</title>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Open+Sans:wght@400;600&display=swap');

        /* Fondo animado con partículas y gradiente */
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background: radial-gradient(circle at center, #0a0a1a 0%, #0f0c29 40%, #302b63 70%, #24243e 100%);
            background-size: 400% 400%;
            animation: gradientShift 10s ease infinite;
            color: #fff;
            font-family: 'Open Sans', sans-serif;
            position: relative;
        }

        @keyframes gradientShift {
            0% {background-position: 0% 50%;}
            50% {background-position: 100% 50%;}
            100% {background-position: 0% 50%;}
        }

        /* Partículas flotantes */
        .particle {
            position: absolute;
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: rgba(0, 255, 255, 0.8);
            animation: float 6s infinite ease-in-out;
            filter: blur(2px);
        }

        @keyframes float {
            0% { transform: translateY(0) scale(1); opacity: 1; }
            50% { transform: translateY(-100px) scale(1.5); opacity: 0.6; }
            100% { transform: translateY(0) scale(1); opacity: 1; }
        }

        /* Título principal */
        .titulo {
            font-family: 'Orbitron', sans-serif;
            font-size: 3.2rem;
            text-align: center;
            color: #00fff2;
            letter-spacing: 5px;
            text-shadow: 0 0 20px #00fff2, 0 0 40px #00fff2;
            animation: pulse 2.5s infinite;
            margin-bottom: 40px;
            z-index: 2;
        }

        @keyframes pulse {
            0%, 100% { text-shadow: 0 0 15px #00fff2, 0 0 30px #00fff2; }
            50% { text-shadow: 0 0 25px #00bfb5, 0 0 50px #00fff2; }
        }

        .card {
            text-align: center;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 25px;
            padding: 50px 40px;
            width: 90%;
            max-width: 420px;
            box-shadow: 0 0 20px rgba(0, 255, 255, 0.25);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            z-index: 2;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0 40px rgba(0, 255, 255, 0.4);
        }

        h2 {
            font-family: 'Orbitron', sans-serif;
            font-size: 1.6rem;
            margin-bottom: 15px;
            color: ${activado ? '#00fff2' : '#ff3c3c'};
            text-shadow: 0 0 10px ${activado ? '#00fff2' : '#ff3c3c'};
        }

        p {
            font-size: 1rem;
            color: #ccc;
            margin-bottom: 30px;
        }

        a.button {
            display: inline-block;
            text-decoration: none;
            color: #000;
            background: ${activado ? '#00fff2' : '#ff3c3c'};
            padding: 12px 25px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        a.button:hover {
            background: #fff;
            color: ${activado ? '#00bfb5' : '#c00000'};
            box-shadow: 0 0 25px ${activado ? '#00fff2' : '#ff3c3c'};
        }

        /* Luces giratorias alrededor */
        .orb {
            position: absolute;
            width: 200px;
            height: 200px;
            border: 2px solid rgba(0, 255, 255, 0.2);
            border-radius: 50%;
            animation: spin 8s linear infinite;
        }

        .orb::before {
            content: "";
            position: absolute;
            width: 12px;
            height: 12px;
            background: #00fff2;
            border-radius: 50%;
            top: -6px;
            left: 50%;
            transform: translateX(-50%);
            box-shadow: 0 0 15px #00fff2;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

    </style>
</head>
<body>
    <!-- Círculo luminoso animado -->
    <div class="orb"></div>

    <!-- Partículas flotantes -->
    <div class="particle" style="top:20%; left:15%; animation-delay:0s;"></div>
    <div class="particle" style="top:60%; left:25%; animation-delay:1s;"></div>
    <div class="particle" style="top:30%; left:70%; animation-delay:2s;"></div>
    <div class="particle" style="top:80%; left:50%; animation-delay:3s;"></div>
    <div class="particle" style="top:40%; left:85%; animation-delay:4s;"></div>

    <!-- Contenido principal -->
    <h1 class="titulo">MÁXIMA CARGA</h1>

    <div class="card">
        <h2>${activado ? "¡Cuenta activada!" : "No se pudo activar la cuenta"}</h2>
        <p>
            ${activado ? 
                "Tu cuenta ha sido verificada exitosamente. Ya puedes iniciar sesión y explorar el sistema." :
                "El enlace de activación puede haber expirado o ya fue usado. Solicita un nuevo envío."}
        </p>
        <a class="button" href="${activado ? 'login.jsp' : 'reenvio.jsp'}">
            ${activado ? "Iniciar sesión" : "Reenviar enlace"}
        </a>
    </div>
</body>
</html>
