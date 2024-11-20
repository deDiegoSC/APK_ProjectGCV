<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Entidad.Productos" %>
<%@ page import="Entidad.Categoria" %>
<%@ page import="Mantenimiento.ProductoDAO" %>
<%@ page import="Mantenimiento.CategoriaDAO" %>
<%@ page import="Servlet.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>ProductosFerre</title>
        <link rel="stylesheet" href="css/need.css">
        <link rel="stylesheet" href="css/footer.css">
        <link rel="stylesheet" href="css/productos.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css"
              integrity="sha512-SzlrxWUlpfuzQ+pcUCosxcglQRNAq/DZjVsC0lE40xsADsfeQoEypE+enwcOiGjk/bSuGGKHEyjSoQ1zVisanQ=="
              crossorigin="anonymous" referrerpolicy="no-referrer"   />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    </head>

    <body>
        <div class="container-fluid mx-auto p-0">
            <!--NAV-->
            <div class="container-fluid">
                <nav class="navbar navbar-expand-md" style="background-color:beige">
                    <div class="container-fluid">
                        <a class="navbar-brand ms-5" href="/WebPageForClient/WebPage.jsp">
                            <img src="../img/LogonoDesign.png" alt="Logo" style="height: 40px; width: auto;">
                        </a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarText"
                                aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon text-light"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarText">
                            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                                <li class="nav-item dropdown ms-5">
                                    <a class="nav-link dropdown-toggle text-bold" href="WebPage.jsp" role="button"
                                       data-bs-toggle="dropdown" aria-expanded="false">
                                        Productos
                                    </a>
                                    <ul class="dropdown-menu" style="background-color:beige">
                                        <%
                                            List<Categoria> catego = CategoriaDAO.listarCategorias();
                                            for (Categoria cate : catego) {
                                        %>
                                        <li><a class="dropdown-item" href="WebPage.jsp#<%= cate.getNameCategory()%>">
                                                <p>En <%= cate.getNameCategory()%></p>
                                            </a></li><%}%>
                                    </ul>
                                </li>
                                <li class="nav-item ms-5">
                                    <a class="nav-link" href="contact.jsp">
                                        <p>Contacto</p>
                                    </a>
                                </li>
                                <%
                                    String nombreCliente = (String) session.getAttribute("nomC");
                                    if (nombreCliente == null) {
                                %>
                                <li class="nav-item ms-5">
                                    <a class="nav-link" href="loginClient.jsp">
                                        <p>Login</p>
                                    </a>
                                </li>
                                <%
                                } else {
                                %>
                                <li class="nav-item ms-5">
                                    <a class="nav-link" href="#">
                                        <p><%= nombreCliente%></p>
                                    </a>
                                </li>
                                <li class="nav-item ms-5">
                                    <a class="nav-link" href="<%= request.getContextPath()%>/ClienteServlet?accion=signoutClient">
                                        <p>Cerrar sesión</p>
                                    </a>
                                </li>
                                <%
                                    }
                                %>
                            </ul>
                        </div>
                    </div>
                </nav>
            </div>
            <!--FIN NAV-->
            <!--PANEL-->
            <div class="container-fluid slogan" style="
                 background: url(../img/MayoristaGolosina.webp);">
                <header>
                    <h1 class="shadow-sm text-light bg-opacity-25 py-3 ms-5">Tienda Mayorista</h1>
                </header>
            </div>
            <!--FIN PANEL-->
            <!--TIENDA-->
            <div class="container-fluid">

                <div class="row align-items-start">
                    <!--NAV-PRODUCTO-->
                    <div class="col-3 shadow-lg" style="height: 1000px; position: sticky; top: 0;">
                        <h1 class="text-center my-5" style="color:gray;">Categorias</h1>
                        <div class="container">
                            <ul>
                                <% List<Categoria> categor = CategoriaDAO.listarCategorias();
                for (Categoria cate : categor) {%>
                                <li class="fs-4 py-4">
                                    <a href="#<%= cate.getNameCategory()%>" style="color:#c93900;">
                                        <%= cate.getNameCategory()%>
                                    </a>
                                </li>
                                <% } %>
                            </ul>
                            <div class="container my-5">
                                <% if (session.getAttribute("nomC") != null) { %>
                                <button type="button" class="btn btn-warning" onclick="verCarrito()">
                                    Ver mi carrito
                                </button>
                                <% }%>
                                <script>
                                    function verCarrito() {
                                        window.location.href = '<%= request.getContextPath()%>/WebPageForClient/confirmacion.jsp';
                                    }
                                </script>
                                <i class="fa-solid fa-cart-shopping fa-2xl" style="color: #bf4808;"></i>
                            </div>
                        </div>
                    </div>
                    <!--FIN NAV-P-->
                    <!--TIENDA-->
                    <div class="col-9">
                        <%
                            List<Categoria> category = CategoriaDAO.listarCategorias();
                            for (Categoria cate : category) {
                        %>
                        <section id="<%= cate.getNameCategory()%>">
                            <h2 class="display-1 py-3 text-center border border-3 rounded-4 shadow-sm" style="background-color: #ffe0ba">-En <%= cate.getNameCategory()%>-</h2>
                            <div class="container d-flex flex-wrap" style="align-content: center;">
                                <%
                                    List<Productos> productos = ProductoDAO.listarProductos();
                                    for (Productos producto : productos) {
                                        if (producto.getIdCategory() == cate.getIdCategory()) {
                                            String modalId = "modalInfo" + producto.getIdProduct();
                                %>
                                <!--CARD-->
                                <form action="<%= request.getContextPath()%>/CartServlet" method="post" class="card mx-auto my-5" style="width: 18rem;">
                                    <img src="<%= producto.getImg()%>" class="card-img-top" alt="...">
                                    <div class="card-body">
                                        <h5 class="card-title h2 py-3 border-top"><%= producto.getNameProduct()%></h5>
                                        <input type="number" name="cantidad" id="cantidad" min="1" max="50" style="width: 100px" required>
                                        <p class="card-text py-3 text-start h3">S/. <%= producto.getPrice()%></p>
                                        <input type="hidden" name="nombre" id="nombre" value="<%= producto.getNameProduct()%>">
                                        <input type="hidden" name="id" id="id" value="<%= producto.getIdProduct()%>">
                                        <input type="hidden" name="imagen" id="imagen" value="<%= producto.getImg()%>">
                                        <input type="hidden" name="precio" id="precio" value="<%= producto.getPrice()%>">
                                        <%
                                            if (session.getAttribute("nomC") != null) {
                                        %>
                                        <button type="submit" class="btn btn-outline-primary">Comprar</button>
                                        <% }%>
                                        <button type="button" class="btn btn-outline-secondary ms-2" data-bs-toggle="modal" data-bs-target="#<%= modalId%>">
                                            Ver información...
                                        </button>
                                    </div>
                                </form>
                                <!--MODAL DE INFO-->
                                <div id="<%= modalId%>" class="modal fade" tabindex="-1">
                                    <div class="modal-dialog modal-lg">
                                        <div class="modal-content">
                                            <div class="modal-header d-flex">
                                                <h2 class="modal-title">Información del Producto</h2>
                                                <button class="btn-close ms-auto" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="container-fluid">
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <img src="<%= producto.getImg()%>" class="img-fluid" alt="...">
                                                        </div>
                                                        <div class="col-md-6 d-flex flex-column">
                                                            <h5 class="card-title fw-bold fs-1"><%= producto.getNameProduct()%></h5>
                                                            <p class="card-text">ID: <%= producto.getIdProduct()%></p>
                                                            <p class="card-text fs-3">Descripción:</p>
                                                            <p class="card-text fs-5"><%= producto.getDescription()%></p>
                                                            <p class="card-text fs-5 mt-auto">Precio: S/. <%= producto.getPrice()%></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <p class="card-text fw-bold mx-auto fs-5">Stock: <%= producto.getStock()%> unidades.</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--FIN MODAL-->
                                <% }
                                    } %>
                                <!--FIN CARD-->
                            </div>
                        </section>
                        <%}%>
                    </div>
                    <!--FIN TIENDA-->
                </div>

            </div>
            <!--FIN TIENDA-->
            <!--FOOTER-->
            <footer>
                <div class="foot">
                    <div>
                        <div class="contenedor">
                            <div class="footer-fila">
                                <div class="links">
                                    <h4>Empresa</h4>
                                    <ul><li><a href="">Mayorista</a></li></ul>
                                </div>
                                <div class="links">
                                    <h4>Productos</h4>
                                    <ul>
                                        <%for (Categoria cate : category) {%>
                                        <li><a href="WebPage.jsp#<%= cate.getNameCategory()%>">En <%= cate.getNameCategory()%></a></li>
                                            <%}%>
                                    </ul>
                                </div>
                                <div class="links">
                                    <h4>Ayuda</h4>
                                    <ul>
                                        <li><a href="Contact.jsp">Comentarios</a></li>
                                        <li><a href="https://www.facebook.com/">Facebook</a></li>
                                        <li><a href="https://web.whatsapp.com/">Whatsapp</a></li>
                                        <li><a href="Contact.jsp">Contactanos</a></li>
                                    </ul>
                                </div>
                                <div class="links">
                                    <h4>Redes Sociales</h4>
                                    <div class="redes">
                                        <a href="https://www.facebook.com/" target="_blank"><i
                                                class="fab fa-facebook-f"></i></a>
                                        <a href="https://www.instagram.com/" target="_blank"><i
                                                class="fab fa-instagram"></i></a>
                                        <a href="https://twitter.com/home?lang=es" target="_blank"><i
                                                class="fab fa-twitter"></i></a>
                                        <a href="https://web.whatsapp.com/" target="_blank"><i
                                                class="fab fa-whatsapp"></i></a>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>
            <!--FIN FOOTER-->
        </div>

    </body>

</html>