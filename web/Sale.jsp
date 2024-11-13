<%-- 
    Document   : Sale
    Created on : 13 nov. 2024, 12:50:38
    Author     : DIEGO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <style>
            .active {
                background-color: #007bff !important;
                color: white !important;
            }
        </style>
        
            <div class="col-md-2 bg-light sidebar" style="height:100vh">
                <h3 class="my-4">Mayorista APK</h3>
                <div class="list-group list-group-flush">
                    <a href="productMaintenance.jsp" class="list-group-item list-group-item-action bg-light">Productos</a>
                    <a href="Sale.jsp" class="list-group-item list-group-item-action bg-light active">Vender</a>
                    <a href="categoryMaintenance.jsp" class="list-group-item list-group-item-action bg-light ">Categorias</a>
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
        
        <h1>Hello World!SALES!!!</h1>
    </body>
</html>
