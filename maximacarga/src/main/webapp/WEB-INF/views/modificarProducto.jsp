<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.maximacarga.dtos.ProductoDto" %>

<%
    ProductoDto producto = (ProductoDto) request.getAttribute("producto");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Modificar producto • Máxima Carga</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #0b0f1a, #0f1c3a);
            min-height: 100vh;
            color: white;
            display: flex;
            flex-direction: column;
        }

        .topbar {
            background: #000;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .topbar a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        .card-custom {
            background: rgba(255,255,255,0.05);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.4);
        }

        .form-control {
            background: rgba(255,255,255,0.1);
            border: none;
            color: white;
        }

        .form-control:focus {
            background: rgba(255,255,255,0.15);
            box-shadow: 0 0 0 2px #ff6a00;
            color: white;
        }

        .btn-main {
            background: linear-gradient(90deg, #ff6a00, #ff8800);
            border: none;
            font-weight: bold;
            letter-spacing: 1px;
        }

        .btn-main:hover {
            background: linear-gradient(90deg, #ff8800, #ff6a00);
        }

        .btn-secondary-custom {
            background: rgba(255,255,255,0.1);
            border: none;
            color: white;
        }

        .btn-secondary-custom:hover {
            background: rgba(255,255,255,0.2);
        }

        footer {
            margin-top: auto;
            padding: 20px;
            text-align: center;
            background: #000;
            color: #aaa;
        }
    </style>
</head>
<body>

<!-- Topbar -->
<div class="topbar">
    <a href="${pageContext.request.contextPath}/admin">← Volver al panel admin</a>
    <span>Modificar producto</span>
</div>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-7">

            <div class="card-custom">

                <h3 class="mb-4 text-center">Editar producto</h3>

                <form action="${pageContext.request.contextPath}/productos/actualizar" 
                      method="post" 
                      enctype="multipart/form-data">

                      <input type="hidden" name="idProducto" 
                           value="<%= producto.getIdProducto() %>">


                    <!-- Nombre -->
                    <div class="mb-3">
                        <label class="form-label">Nombre</label>
                        <input type="text" name="nombre" class="form-control"
                               value="<%= producto.getNombre() %>" required>
                    </div>

                    <!-- Descripción -->
                    <div class="mb-3">
                        <label class="form-label">Descripción</label>
                        <textarea name="descripcion" class="form-control" rows="3" required><%= producto.getDescripcion() %></textarea>
                    </div>

                    <!-- Precio -->
                    <div class="mb-3">
                        <label class="form-label">Precio (€)</label>
                        <input type="number" step="0.01" name="precio"
                               class="form-control"
                               value="<%= producto.getPrecio() %>" required>
                    </div>

                    <!-- Stock -->
                    <div class="mb-3">
                        <label class="form-label">Stock</label>
                        <input type="number" name="stock"
                               class="form-control"
                               value="<%= producto.getStock() %>" required>
                    </div>

                    <!-- Imagen -->
                    <div class="mb-4">
                        <label class="form-label">Cambiar imagen (opcional)</label>
                        <input type="file" name="imagen" class="form-control">
                    </div>

                    <div class="d-flex justify-content-between">
                        <a href="${pageContext.request.contextPath}/productos/listar"
                           class="btn btn-secondary-custom">
                            Cancelar
                        </a>

                        <button type="submit" class="btn btn-main px-4">
                            Guardar cambios
                        </button>
                    </div>

                </form>

            </div>

        </div>
    </div>
</div>

<footer>
    © 2026 Máxima Carga • Panel de administración
</footer>

</body>
</html>
