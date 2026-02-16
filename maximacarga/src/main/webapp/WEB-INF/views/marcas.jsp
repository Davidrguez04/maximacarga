<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Marcas destacadas · Máxima Carga</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            background: radial-gradient(circle at top, #1f2937 0, #020617 70%);
            font-family: system-ui, sans-serif;
            color: #e5e7eb;
        }

        .section {
            padding: 4rem 2rem;
            max-width: 1200px;
            margin: auto;
        }

        .title {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 2rem;
            text-transform: uppercase;
        }

        .brand-card {
            background: #0b1120;
            border-radius: 1.2rem;
            padding: 2rem;
            text-align: center;
            transition: 0.3s;
            border: 1px solid #1f2937;
        }

        .brand-card:hover {
            transform: translateY(-6px);
            border-color: #f59e0b;
        }

        .brand-card img {
            max-height: 60px;
            margin-bottom: 1rem;
            filter: brightness(0.9);
        }

        .btn-back {
            background: #f59e0b;
            color: #111827;
            border-radius: 999px;
            padding: 0.6rem 1.5rem;
            font-weight: 600;
            border: none;
        }

        .btn-back:hover {
            background: #d97706;
        }
    </style>
</head>
<body>

<div class="section">
    <h1 class="title">Marcas destacadas</h1>

    <div class="row g-4">

        <div class="col-md-4">
            <div class="brand-card">
                <img src="https://via.placeholder.com/150x60?text=PRO+FIT" alt="">
                <h5>ProFit</h5>
                <p>Equipamiento profesional de alto rendimiento.</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="brand-card">
                <img src="https://via.placeholder.com/150x60?text=MAX+NUTRITION" alt="">
                <h5>Max Nutrition</h5>
                <p>Suplementación avanzada para atletas exigentes.</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="brand-card">
                <img src="https://via.placeholder.com/150x60?text=IRON+GEAR" alt="">
                <h5>Iron Gear</h5>
                <p>Accesorios premium para entrenamientos intensos.</p>
            </div>
        </div>

    </div>

    <div class="mt-5">
        <a href="${pageContext.request.contextPath}/" class="btn btn-back">
            ← Volver al inicio
        </a>
    </div>
</div>

</body>
</html>
