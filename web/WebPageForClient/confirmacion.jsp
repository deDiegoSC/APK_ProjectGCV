<%@page import="Mantenimiento.CategoriaDAO"%>
<%@page import="Entidad.Categoria"%>
<%@page import="Servlet.CartServlet.Producto"%>
<%@ page import="java.util.List" %>
<%
    List<Producto> carrito = (List<Producto>) session.getAttribute("carrito");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Carrito APK</title>
        <link rel="stylesheet" href="css/need.css">
        <link rel="stylesheet" href="css/footer.css">
        <link rel="stylesheet" href="css/carrito.css">
        <link rel="stylesheet" href="css/productos.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css"
              integrity="sha512-SzlrxWUlpfuzQ+pcUCosxcglQRNAq/DZjVsC0lE40xsADsfeQoEypE+enwcOiGjk/bSuGGKHEyjSoQ1zVisanQ=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"
                integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5/0cq4ri5O1U2pEOQH5a45GJZcbf2s9j9b4Tij+j"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
        <style>
            .selected {
                background-color: #f5f5dc;
                border-radius: 50%;
                padding: 5px;
            }
        </style>
    </head>
    <body>
        <header>
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
                                        <%                                            List<Categoria> catego = CategoriaDAO.listarCategorias();
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
        </header>

        <main class="container mt-5">
            <h1 class="mb-4">Carrito de Compras</h1>
            <%
                double total = 0;
                if (carrito != null && !carrito.isEmpty()) {
            %>
            <div class="productos-contenedor">
                <% for (Producto producto : carrito) {
                        total += producto.getSubtotal();
                %>
                <div class="producto">
                    <img src="<%= producto.getImagen()%>" alt="<%= producto.getNombre()%>" class="producto-imagen">
                    <div class="producto-info">
                        <h2 class="producto-nombre"><%= producto.getNombre()%></h2>
                        <p class="producto-cantidad">Cantidad: <%= producto.getCantidad()%></p>
                        <p class="producto-precio">Precio unitario: S/. <%= producto.getPrecio()%></p>
                        <p class="producto-total">Total: S/. <%= producto.getSubtotal()%></p>
                    </div>
                </div>
                <% }%>
            </div>
            <div class="container mt-5">
                <div class="row justify-content-center">
                    <div class="col-md-6 text-center">
                        <!-- Primer botón que abre el modal -->
                        <div class="row">
                            <div class="col">
                                <label>Puede con: </label>
                            </div>
                            <div class="col selectable" onclick="toggleSelection(this)">
                                <i class="fa-brands fa-cc-mastercard fa-xl" style="color: #ff0000;"></i>
                            </div>
                            <div class="col selectable" onclick="toggleSelection(this)">
                                <i class="fa-solid fa-shop fa-xl" style="color: #603fc6;"></i>
                            </div>
                            <div class="col selectable" onclick="toggleSelection(this)">
                                <i class="fa-brands fa-paypal fa-xl"></i>
                            </div>
                            <script>
                                function toggleSelection(element) {
                                    const icons = document.querySelectorAll('.selectable');
                                    icons.forEach(icon => {
                                        icon.classList.remove('selected');
                                    });
                                    element.classList.add('selected');
                                }
                            </script>
                            <div class="col">
                                <button type="button" id="btnAbrirModal" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#modalConfirmacion">
                                    Comprar
                                </button>
                            </div> 
                            <!-- Segundo botón oculto -->
                            <div class="col">
                                <form action="<%= request.getContextPath()%>/CompraServlet" method="post">
                                    <button id="btnCompra" type="submit" class="btn btn-primary mb-3" style="display: none;">
                                        Comprar
                                    </button>
                                </form>
                            </div>
                        </div>
                        <div class="col">
                            <p>Total: S/. <%= total%></p>
                        </div>
                        <!-- MODAL - CUESTIONARIO - COMPRA -->
                        <div class="modal fade" id="modalConfirmacion" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="modalLabel">Confirmar Compra</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                                    </div>
                                    <div class="modal-body">
                                        <p>¿Cómo deseas recibir tu pedido?</p>
                                        <div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="tipoEntrega" id="opcionTienda" value="tienda" checked>
                                                <label class="form-check-label" for="opcionTienda">
                                                    Recoger en tienda (sin costo adicional)
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="tipoEntrega" id="opcionDelivery" value="delivery">
                                                <label class="form-check-label" for="opcionDelivery">
                                                    Delivery (Costo adicional: S/. <span id="precioDelivery">10.00</span>)
                                                </label>
                                            </div>
                                        </div>
                                        <div class="mt-3">
                                            <p><strong>Total con delivery:</strong> S/. <span id="totalConDelivery">S/. <%= total%></span></p>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                        <button type="button" id="btnConfirmar" class="btn btn-primary" data-bs-dismiss="modal">Confirmar</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        const opcionTienda = document.getElementById("opcionTienda");
                        const opcionDelivery = document.getElementById("opcionDelivery");
                        const precioDelivery = 10.00;
                        const totalConDelivery = document.getElementById("totalConDelivery");
                        const totalBase = parseFloat("<%= total%>");
                        function actualizarTotal() {
                            if (opcionDelivery.checked) {
                                totalConDelivery.innerText = "S/. " + (totalBase + precioDelivery).toFixed(2);
                            } else {
                                totalConDelivery.innerText = "S/. " + totalBase.toFixed(2);
                            }
                        }
                        opcionTienda.addEventListener("change", actualizarTotal);
                        opcionDelivery.addEventListener("change", actualizarTotal);
                        actualizarTotal();
                        const btnConfirmar = document.getElementById("btnConfirmar");
                        btnConfirmar.addEventListener("click", function () {
                            if (opcionDelivery.checked) {
                                console.log("El usuario seleccionó delivery con un costo adicional.");
                            } else {
                                console.log("El usuario recogerá en tienda.");
                            }
                            document.getElementById("btnAbrirModal").style.display = "none";
                            document.getElementById("btnCompra").style.display = "inline-block";
                        });
                    });
                </script>
            </div>

            <%
            } else {
            %>
            <p>No hay productos en el carrito. Añade productos antes de continuar.</p>
            <% } %>

            <%
                Boolean exitos = (Boolean) session.getAttribute("exito");
                if (exitos != null) {
                    if (exitos) {
            %>
            <script>alert("¡Compra Exitosa!");</script>
            <%
            } else {
            %>
            <script>alert("Error en la compra: Stock insuficiente.");</script>
            <%
                    }
                    session.removeAttribute("exito");
                }
            %>
        </main>            
        <!--FOOTER-->
        <footer>
            <div class="foot">
                <div>
                    <div class="contenedor">
                        <div class="footer-fila">
                            <div class="links">
                                <h4>Empresa</h4>
                                <ul><li><a href="">APK Mayorista</a></li></ul>
                            </div>
                            <div class="links">
                                <h4>Productos</h4>
                                <ul>
                                    <%for (Categoria cate : catego) {%>
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
    </body>
</html>
