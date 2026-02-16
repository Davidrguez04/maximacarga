<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ofertas especiales · Máxima Carga</title>

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

        .offer-card {
            background: linear-gradient(135deg, #0b1120, #111827);
            border-radius: 1.2rem;
            padding: 2rem;
            border: 1px solid #1f2937;
            transition: 0.3s;
        }

        .offer-card:hover {
            transform: translateY(-6px);
            border-color: #f59e0b;
        }

        .price {
            font-size: 1.8rem;
            font-weight: 700;
            color: #f59e0b;
        }

        .old-price {
            text-decoration: line-through;
            color: #9ca3af;
            font-size: 1rem;
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
    <h1 class="title">Ofertas especiales</h1>

    <div class="row g-4">

        <div class="col-md-6">
            <div class="offer-card">
                <h4>Pack Proteína + Shaker</h4>
                <p>Combo exclusivo para maximizar tu recuperación.</p>
                <span class="old-price">59,99€</span>
                <div class="price">39,99€</div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="offer-card">
                <h4>Guantes + Cinturón Pro</h4>
                <p>Protección y soporte para tus levantamientos.</p>
                <span class="old-price">49,99€</span>
                <div class="price">29,99€</div>
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
