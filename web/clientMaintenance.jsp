<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Entidad.Cliente" %>
<%@ page import="Mantenimiento.ClienteDAO" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Lista de Clientes - Mayorista APK</title>

        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="../css/styles.css" rel="stylesheet">
    </head>
    <style>
        .active {
            background-color: #007bff !important;
            color: white !important;
        }
    </style>
    <body>
        <div class="container-fluid">
            <div class="row">

                
                    <div class="col-md-2 bg-light sidebar" style="height:100vh">
                        <h3 class="my-4">Mayorista APK</h3>
                        <div class="list-group list-group-flush">
                            <a href="productMaintenance.jsp" class="list-group-item list-group-item-action bg-light">Productos</a>
                            <a href="Sale.jsp" class="list-group-item list-group-item-action bg-light">Vender</a>
                            <a href="categoryMaintenance.jsp" class="list-group-item list-group-item-action bg-light">Categorias</a>
                            <a href="clientMaintenance.jsp" class="list-group-item list-group-item-action bg-light active">Clientes</a>
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
                    <h2 class="my-4">Lista de Clientes</h2>
                    <% if (request.getParameter("error") != null) { %>
                    <div class="alert alert-danger" role="alert">
                        Ha ocurrido un error.
                    </div>
                    <% } %>
                    <button class="btn btn-primary mb-3" data-toggle="modal" data-target="#nuevoClienteModal">Nuevo Cliente</button>
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Apellido</th>
                                <th>Correo</th>
                                <th>Telefono</th>
                                <th>Direccion</th>
                                <th>Acciones</th>

                            </tr>
                        </thead>
                        <tbody>
                            <%
                                ClienteDAO clienteDAO = new ClienteDAO();
                                List<Cliente> clientes = clienteDAO.listarClientes();
                                for (Cliente cliente : clientes) {
                            %>
                            <tr>
                                <td><%= cliente.getIdClient()%></td>
                                <td><%= cliente.getName()%></td>
                                <td><%= cliente.getLastname()%></td>
                                <td><%= cliente.getEmail()%></td>
                                <td><%= cliente.getPhone()%></td>
                                <td><%= cliente.getAddress()%></td>
                                <td>
                                    <button class="btn btn-warning btn-sm">Actualizar</button>
                                    <button class="btn btn-danger btn-sm delete-btn" data-toggle="modal" data-target="#eliminarClienteModal" data-id="<%= cliente.getIdClient()%>">Eliminar</button>
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

        <div class="modal fade" id="nuevoClienteModal" tabindex="-1" role="dialog" aria-labelledby="nuevoClienteModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="nuevoClienteModalLabel">Nuevo Cliente</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form method="post" action="ClienteServlet">
                        <input type="hidden" name="action" value="add">
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="name">Nombre del Cliente</label>
                                <input type="text" class="form-control" id="name" name="name" required>
                            </div>
                            <div class="form-group">
                                <label for="lastname">Apellido</label>
                                <input type="text" class="form-control" id="lastname" name="lastname" required>
                            </div>
                            <div class="form-group">
                                <label for="email">Correo</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                            <div class="form-group">
                                <label for="phone">Telefono</label>
                                <input type="text" class="form-control" id="phone" name="phone" pattern="\d{9}" title="Debe contener 9 dígitos" required>
                            </div>
                            <div class="form-group">
                                <label for="address">Direccion</label>
                                <input type="text" class="form-control" id="address" name="address" required>
                            </div>
                            <div class="form-group">
                                <label for="password">Contraseña</label>
                                <input type="password" class="form-control" id="password" name="password" required>
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

        <div class="modal fade" id="actualizarClienteModal" tabindex="-1" role="dialog" aria-labelledby="actualizarClienteModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="actualizarClienteModalLabel">Actualizar Cliente</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form method="post" action="ClienteServlet" onsubmit="return validateForm()">
                        <input type="hidden" name="action" value="update">
                        <div class="modal-body">
                            <input type="hidden" id="clienteId" name="clienteId">
                            <div class="form-group">
                                <label for="name">Nombre del Cliente</label>
                                <input type="text" class="form-control" id="name" name="name" required>
                            </div>
                            <div class="form-group">
                                <label for="lastname">Apellido</label>
                                <input type="text" class="form-control" id="lastname" name="lastname" required>
                            </div>
                            <div class="form-group">
                                <label for="email">Correo</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                            <div class="form-group">
                                <label for="phone">Teléfono</label>
                                <input type="text" class="form-control" id="phone" name="phone" pattern="\d{9}" title="Debe contener 9 dígitos" required>
                            </div>
                            <div class="form-group">
                                <label for="address">Direccion</label>
                                <input type="text" class="form-control" id="address" name="address" required>
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

        <div class="modal fade" id="eliminarClienteModal" tabindex="-1" role="dialog" aria-labelledby="eliminarClienteModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="eliminarClienteModalLabel">Eliminar Cliente</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form method="post" action="ClienteServlet">
                        <input type="hidden" name="action" value="delete">
                        <div class="modal-body">
                            <input type="hidden" id="idClient" name="idClient">
                            <p>¿Está seguro de que desea eliminar a este cliente?</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-danger">Eliminar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <script>
                        $(document).ready(function () {
                            $('.btn-warning').on('click', function () {
                                var row = $(this).closest('tr');
                                var id = row.find('td:eq(0)').text();
                                var nombre = row.find('td:eq(1)').text();
                                var apellido = row.find('td:eq(2)').text();
                                var correo = row.find('td:eq(3)').text();
                                var telefono = row.find('td:eq(4)').text();
                                var direccion = row.find('td:eq(5)').text();

                                $('#clienteId').val(id);
                                $('#name').val(nombre);
                                $('#lastname').val(apellido);
                                $('#email').val(correo);
                                $('#phone').val(telefono);
                                $('#address').val(direccion);
                                $('#actualizarClienteModal').modal('show');
                            });

                            $('.delete-btn').on('click', function () {
                                var id = $(this).data('id');
                                $('#idClient').val(id);
                                $('#eliminarClienteModal').modal('show');
                            });
                        });

                        function validateForm(form) {
                            var telefono = form.phone ? form.phone.value : form.phone.value;
                            if (telefono.length !== 9) {
                                alert("El teléfono debe contener 9 dígitos.");
                                return false;
                            }
                            return true;
                        }
        </script>
    </body>
</html>