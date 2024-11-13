<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Entidad.Venta" %>
<%@ page import="Entidad.DetalleVenta" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Reporte de Ventas Diarias - Mayorista APK</title>

        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <script src="js/jspdf.umd.min.js"></script>
        <link href="../css/styles.css" rel="stylesheet">
        <style>
            .active {
                background-color: #007bff !important;
                color: white !important;
            }
            .summary-card {
                border-radius: 15px;
                padding: 20px;
                margin: 10px;
                color: #fff;
                text-align: center;
            }
            .bg-red {
                background-color: #FF6B6B;
            }
            .bg-orange {
                background-color: #FFA26B;
            }
            .bg-green {
                background-color: #6BCB77;
            }
            .bg-purple {
                background-color: #A26BFF;
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
                            <a href="categoryMaintenance.jsp" class="list-group-item list-group-item-action bg-light">Categorias</a>
                            <a href="clientMaintenance.jsp" class="list-group-item list-group-item-action bg-light">Clientes</a>
                            <a href="monthReport.jsp" class="list-group-item list-group-item-action bg-light">Reporte Mensual</a>
                            <a href="dayReport.jsp" class="list-group-item list-group-item-action bg-light active">Reporte Diario</a>
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
                    <h2 class="my-4">Reporte de Ventas Diarias</h2>
                    <form method="post" action="ReporteDiaServlet">
                        <div class="form-group">
                            <label for="fecha">Fecha</label>
                            <input type="date" class="form-control" id="fecha" name="fecha" required>
                        </div>

                        <button type="submit" class="btn btn-primary">Generar Reporte</button>
                        <button type="button" id="downloadPDF" class="btn btn-secondary">Descargar PDF</button>
                    </form>
                    <div class="mt-4">
                        <h3>Ventas del <%= request.getParameter("fecha")%></h3>

                        <div class="row">
                            <div class="col-md-3">
                                <div class="summary-card bg-red">
                                    <h4 id="totalVentas">S/.<%= request.getAttribute("totalVentas")%></h4>
                                    <p>Venta total</p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="summary-card bg-orange">
                                    <h4 id="totalOrdenes"><%= request.getAttribute("totalOrdenes")%></h4>
                                    <p>Total de ordenes</p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="summary-card bg-green">
                                    <h4 id="totalProductos"><%= request.getAttribute("totalProductos")%></h4>
                                    <p>Productos vendidos</p>
                                </div>
                            </div>
                        </div>
                        <table class="table table-hover mt-4">
                            <thead>
                                <tr>
                                    <th>Producto</th>
                                    <th>Cantidad</th>
                                    <th>Total Vendido</th>
                                </tr>
                            </thead>
                            <tbody id="detalleVentas">
                                <%
                                    List<Venta> ventas = (List<Venta>) request.getAttribute("ventas");
                                    if (ventas != null) {
                                        for (Venta venta : ventas) {
                                            List<DetalleVenta> detalles = venta.getDetalles();
                                            for (DetalleVenta detalle : detalles) {
                                %>
                                <tr>
                                    <td><%= detalle.getProductName()%></td> 
                                    <td><%= detalle.getAmount()%></td>
                                    <td>S/.<%= detalle.getPrice()%></td>
                                </tr>
                                <%
                                            }
                                        }
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.getElementById('downloadPDF').addEventListener('click', () => {
                const {jsPDF} = window.jspdf;
                const doc = new jsPDF();
                const fecha = document.getElementById('fecha').value;

                doc.setFontSize(18);
                doc.text('Reporte de Ventas Diarias', 14, 22);


                doc.setFontSize(12);
                const fechaVenta = document.querySelector('h3').textContent;
                doc.text(fechaVenta, 14, 32);


                doc.setFontSize(10);
                const totalVentas = document.getElementById('totalVentas') ? document.getElementById('totalVentas').textContent : 'N/A';
                const totalOrdenes = document.getElementById('totalOrdenes') ? document.getElementById('totalOrdenes').textContent : 'N/A';
                const totalProductos = document.getElementById('totalProductos') ? document.getElementById('totalProductos').textContent : 'N/A';
                        doc.text(Venta total: ${totalVentas}, 14, 42);
                        doc.text(Total de ordenes: ${totalOrdenes}, 14, 50);
                        doc.text(Productos vendidos: ${totalProductos}, 14, 58);


                doc.text('Producto', 14, 70);
                doc.text('Cantidad', 64, 70);
                doc.text('Total Vendido', 114, 70);


                const rows = document.querySelectorAll('#detalleVentas tr');
                let y = 80;
                rows.forEach(row => {
                    const cells = row.querySelectorAll('td');
                    doc.text(cells[0].textContent, 14, y);
                    doc.text(cells[1].textContent, 64, y);
                    doc.text(cells[2].textContent, 114, y);
                    y += 10;
                });

                doc.save('reporte_ventas_diarias.pdf');
            });
        </script>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>