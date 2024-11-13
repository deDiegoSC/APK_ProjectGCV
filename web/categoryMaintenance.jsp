<%-- 
    Document   : categoryMaintenance
    Created on : 13 nov. 2024, 10:24:24
    Author     : DIEGO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Entidad.Productos" %>
<%@ page import="Entidad.Categoria" %>
<%@ page import="Entidad.Empleado" %>
<%@ page import="Mantenimiento.CategoriaDAO" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ControlCategoria - APK</title>
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
                            <a href="productMaintenance.jsp" class="list-group-item list-group-item-action bg-light">Productos</a>
                            <a href="Sale.jsp" class="list-group-item list-group-item-action bg-light">Vender</a>
                            <a href="categoryMaintenance.jsp" class="list-group-item list-group-item-action bg-light active">Categorias</a>
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
                    <h2 class="my-4">Lista de Categorias</h2>
                    <% if (request.getParameter("error") != null) { %>
                    <div class="alert alert-danger" role="alert">
                        Ha ocurrido un error al agregar la categoria.
                    </div>
                    <%  } %>
                    <button class="btn btn-primary mb-3" data-toggle="modal" data-target="#nuevaCategoriaModal">Nueva Categoria</button>
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Categoria</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Categoria> categorias = CategoriaDAO.listarCategorias();
                                for (Categoria categoria : categorias) {
                            %>
                            <tr data-categoria-id="<%= categoria.getIdCategory()%>">
                                <td><%= categoria.getIdCategory()%></td>
                                <td><%= categoria.getNameCategory()%></td>
                                <td>
                                    <button class="btn btn-warning btn-sm" data-toggle="modal" data-target="#actualizarCategoriaModal" data-id="<%= categoria.getIdCategory()%>">Actualizar</button>
                                    <button class="btn btn-danger btn-sm delete-btn" data-toggle="modal" data-target="#eliminarCategoriaModal" data-id="<%= categoria.getIdCategory()%>">Eliminar</button>
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


        <div class="modal fade" id="nuevaCategoriaModal" tabindex="-1" role="dialog" aria-labelledby="nuevaCategoriaModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="nuevaCategoriaModalLabel">Nueva Categoria</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form method="post" action="CategoryServlet">
                        <input type="hidden" name="action" value="add">
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="nameCategory">Nombre de la Categoria</label>
                                <input type="text" class="form-control" id="nameCategory" name="nameCategory" required>
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


        <div class="modal fade" id="actualizarCategoriaModal" tabindex="-1" role="dialog" aria-labelledby="actualizarCategoriaModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="actualizarCategoriaModalLabel">Actualizar Categoria</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form method="post" action="CategoryServlet">
                        <input type="hidden" name="action" value="update">
                        <div class="modal-body">
                            <input type="hidden" id="idCategory" name="idCategory">

                            <div class="form-group">
                                <label for="nameCategory">Nombre de la Categoria</label>
                                <input type="text" class="form-control" id="updateNameCategory" name="nameCategory" required>
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


        <div class="modal fade" id="eliminarCategoriaModal" tabindex="-1" role="dialog" aria-labelledby="eliminarCategoriaModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="eliminarCategoriaModalLabel">Eliminar Categoria</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form method="post" action="CategoryServlet">
                        <input type="hidden" name="action" value="delete">
                        <div class="modal-body">
                            <input type="hidden" id="categoriaIdEliminar" name="idCategory">
                            <p>¿Estás seguro de que deseas eliminar esta categoria?</p>
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

            $('#actualizarCategoriaModal').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget);
                var id = button.data('id');
                var row = button.closest('tr');
                var nombre = row.find('td:eq(1)').text();

                var modal = $(this);
                modal.find('#idCategory').val(id);
                console.log("ID Categoria: " + $('#idCategory').val());
                modal.find('#nameCategory').val(nombre);
            });

            $('#eliminarCategoriaModal').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget);
                var id = button.data('id');
                var modal = $(this);
                modal.find('#categoriaIdEliminar').val(id);
            });


        </script>
    </body>
</html>
