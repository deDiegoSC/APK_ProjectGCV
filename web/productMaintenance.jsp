<%-- 
    Document   : productMaintenance
    Created on : 13 nov. 2024, 00:55:18
    Author     : DIEGO
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Entidad.Productos" %>
<%@ page import="Entidad.Categoria" %>
<%@ page import="Entidad.Empleado" %>
<%@ page import="Mantenimiento.ProductoDAO" %>
<%@ page import="Mantenimiento.CategoriaDAO" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>ControlProductos - APK</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css">
        <style>
            .active {
                background-color: #007bff !important;
                color: white !important;
            }
            .product-img {
                width: 50px;
                height: 50px;
                object-fit: cover;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                
                    <div class="col-md-2 bg-light sidebar" style="height:100vh">
                        <h3 class="my-4">Mayorista APK</h3>
                        <div class="list-group list-group-flush">
                            <a href="productMaintenance.jsp" class="list-group-item list-group-item-action bg-light active">Productos</a>
                            <a href="Sale.jsp" class="list-group-item list-group-item-action bg-light">Vender</a>
                            <a href="categoryMaintenance.jsp" class="list-group-item list-group-item-action bg-light">Categorias</a>
                            <a href="clientMaintenance.jsp" class="list-group-item list-group-item-action bg-light">Clientes</a>
                            <a href="monthReport.jsp" class="list-group-item list-group-item-action bg-light">Reporte Mensual</a>
                            <a href="dayReport.jsp" class="list-group-item list-group-item-action bg-light">Reporte Diario</a>
                            <a href="clientReport.jsp" class="list-group-item list-group-item-action bg-light">Reporte Cliente</a>
                            <%  String nameEmployee = "";
                                nameEmployee = (String) session.getAttribute("nameEmployee");
                                if (!nameEmployee.equals("")) {%>
                            <div class="mt-5 ms-2">
                                <table class="table">
                                    <tr>
                                        <td><h2><i class="bi bi-person fs-1"></i></h2></td>
                                        <td><h3><%= nameEmployee%></h3></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>
                                            <div class="mt-5 d-flex justify-content-end">
                                                <a class="btn btn-warning" href="<%= request.getContextPath()%>/EmployeeServlet?action=signout">
                                                    Cerrar sesión
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <%}%>
                        </div>
                    </div>
                

                <div class="col-md-10">
                    <h2 class="my-4">Lista de Productos</h2>
                    <% if (request.getParameter("error") != null) { %>
                    <div class="alert alert-danger" role="alert">
                        Ha ocurrido un error al agregar el producto.
                    </div>
                    <%  } %>
                    <button class="btn btn-primary mb-3" data-toggle="modal" data-target="#nuevoProductoModal">Nuevo Producto</button>
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Producto</th>
                                <th>Descripcion</th>
                                <th>Precio</th>
                                <th>Stock</th>
                                <th>Categoría</th>
                                <th>Imagen</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Productos> productos = ProductoDAO.listarProductos();
                                List<Categoria> categorias = CategoriaDAO.listarCategorias();
                                for (Productos producto : productos) {
                            %>
                            <tr data-categoria-id="<%= producto.getIdCategory()%>">
                                <td><%= producto.getIdProduct()%></td>
                                <td><%= producto.getNameProduct()%></td>
                                <td><%= producto.getDescription()%></td>
                                <td><%= producto.getPrice()%></td>
                                <td><%= producto.getStock()%></td>
                                <td><%= CategoriaDAO.obtenerNombreCategoria(producto.getIdCategory())%></td>
                                <td><img src="<%= producto.getImg()%>" alt="Imagen del producto" width="100"></td>
                                <td>
                                    <button class="btn btn-warning btn-sm" 
                                            data-toggle="modal" 
                                            data-target="#actualizarProductoModal" 
                                            data-id="<%= producto.getIdProduct()%>"
                                            data-name="<%= producto.getNameProduct()%>"
                                            data-description="<%= producto.getDescription()%>"
                                            data-price="<%= producto.getPrice()%>"
                                            data-stock="<%= producto.getStock()%>"
                                            data-category="<%= producto.getIdCategory()%>"
                                            data-img="<%= producto.getImg()%>">
                                        Actualizar
                                    </button>                                    
                                    <button class="btn btn-danger btn-sm delete-btn" data-toggle="modal" data-target="#eliminarProductoModal" data-id="<%= producto.getIdProduct()%>">Eliminar</button>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>


        <div class="modal fade" id="nuevoProductoModal" tabindex="-1" role="dialog" aria-labelledby="nuevoProductoModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="nuevoProductoModalLabel">Nuevo Producto</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form method="post" action="AddProductServlet">
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="nameProduct">Nombre del Producto</label>
                                <input type="text" class="form-control" id="nameProduct" name="nameProduct" required>
                            </div>
                            <div class="form-group">
                                <label for="description">Descripción</label>
                                <input type="text" class="form-control" id="description" name="description" required>
                            </div>
                            <div class="form-group">
                                <label for="price">Precio</label>
                                <input type="number" step="0.01" class="form-control" id="price" name="price" required>
                            </div>
                            <div class="form-group">
                                <label for="category">Categoría</label>
                                <select class="form-control" id="category" name="category" required>
                                    <% for (Categoria categoria : categorias) {%>
                                    <option value="<%= categoria.getIdCategory()%>"><%= categoria.getNameCategory()%></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="stock">Stock</label>
                                <input type="number" class="form-control" id="stock" name="stock" required>
                            </div>
                            <div class="form-group">
                                <label for="img">URL de la Imagen del Producto</label>
                                <input type="text" class="form-control" id="img" name="img" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                            <button type="submit" class="btn btn-primary">Guardar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>


        <div class="modal fade" id="actualizarProductoModal" tabindex="-1" role="dialog" aria-labelledby="actualizarProductoModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="actualizarProductoModalLabel">Actualizar Producto</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form method="post" action="updateProductServlet" onsubmit="return validateForm()">
                        <div class="modal-body">
                            <input type="hidden" id="idProduct" name="idProduct">
                            <div class="form-group">
                                <label for="nameProduct">Nombre del Producto</label>
                                <input type="text" class="form-control" id="nameProduct" name="nameProduct" required>
                            </div>
                            <div class="form-group">
                                <label for="description">Descripcion</label>
                                <input type="text" class="form-control" id="description" name="description" required>
                            </div>
                            <div class="form-group">
                                <label for="price">Precio</label>
                                <input type="text" class="form-control" id="price" name="price" required>
                            </div>
                            <div class="form-group">
                                <label for="category">Categoría</label>
                                <select class="form-control" id="category" name="category" required>
                                    <% for (Categoria categoria : categorias) {%>
                                    <option value="<%= categoria.getIdCategory()%>"><%= categoria.getNameCategory()%></option>
                                    <% }%>
                                </select>
                            </div>
                            <div class="form-group">

                                <label for="stock">Stock</label>
                                <input type="number" class="form-control" id="stock" name="stock" required>
                            </div>
                            <div class="form-group">
                                <label for="img">URL de la Imagen del Producto</label>
                                <input type="text" class="form-control" id="img" name="img" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                            <button type="submit" class="btn btn-primary">Actualizar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>


        <div class="modal fade" id="eliminarProductoModal" tabindex="-1" role="dialog" aria-labelledby="eliminarProductoModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="eliminarProductoModalLabel">Eliminar Producto</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form method="post" action="deleteProductServlet">
                        <div class="modal-body">
                            <input type="hidden" id="productoIdEliminar" name="productoId">
                            <p>¿Estás seguro de que deseas eliminar este producto?</p>
                        </div>
                        <div class="modal-footer">

                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                            <button type="submit" class="btn btn-danger">Eliminar</button>

                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>

                        $('#actualizarProductoModal').on('show.bs.modal', function (event) {
                            var button = $(event.relatedTarget); // Botón que activó el modal
                            var id = button.data('id'); // Obtener el ID del producto

                            // Mostrar el ID en una ventana de alerta
                            alert('ID del producto seleccionado: ' + id);

                            // Rellenar los campos del formulario
                            var name = button.data('name');
                            var description = button.data('description');
                            var price = button.data('price');
                            var stock = button.data('stock');
                            var category = button.data('category');
                            var img = button.data('img');

                            // Establecer los valores en el formulario
                            var modal = $(this);
                            modal.find('#idProduct').val(id);
                            modal.find('#nameProduct').val(name);
                            modal.find('#description').val(description);
                            modal.find('#price').val(price);
                            modal.find('#stock').val(stock);
                            modal.find('#category').val(category);
                            modal.find('#img').val(img);
                        });

                        $('#eliminarProductoModal').on('show.bs.modal', function (event) {
                            var button = $(event.relatedTarget);
                            var id = button.data('id');
                            var modal = $(this);
                            modal.find('#productoIdEliminar').val(id);
                        });


        </script>
    </body>
</html>