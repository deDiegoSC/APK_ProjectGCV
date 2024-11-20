
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Inicio de Sesion</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="CSS/StyleLogin.css">
    </head>
    <body>
        <section class="vh-100">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-6 text-black">

                        <div class="px-5">
                            <i class="fas fa-crow fa-2x me-3 pt-5 mt-xl-4" style="color: #709085;"></i>
                            <span class="h1 fw-bold mb-0">Mayorista Vania, Fabian y Mauricio</span>
                            <hr>
                            <img src="img/LogonoDesign.png" style="witdh:200px; height: 400px">
                        </div>

                        <div class="h-custom-2 px-5 ms-xl-4 pt-xl-0 mt-xl-n5" >

                            <form action="EmployeeServlet" method="post" style="width: 23rem;">
                                <input type="hidden" name="action" value="login">
                                <h2 class="fw-bold mb-3 pb-3" style="letter-spacing: 1px;">Ingresar</h2>

                                <div class="form-outline mb-4">
                                    <input type="text" id="usuario" name="usuario" class="form-control form-control-lg" required/>
                                    <label class="form-label" for="usuario">Usuario</label>
                                </div>

                                <div class="form-outline mb-4">
                                    <input type="password" class="form-control form-control-lg" id="contrasena" name="contrasena" required/>
                                    <label class="form-label" for="contrasena">Contrase?a</label>
                                </div>

                                <div class="pt-1 mb-4">
                                    <button class="btn btn-info btn-lg btn-block" type="submit">Ingresar</button>
                                </div>
                                <div class="text-center">
                                    <p>Nuevo empleado? <a href="registerEmployee.jsp">Registrar Empleado</a></p>
                                </div>
                            </form>
                            <div class="text-center">
                                    <p>Eres cliente? <a href="WebPageForClient/WebPage.jsp">Vamos a la tienda!</a></p>
                                </div>

                        </div>

                    </div>
                    <div class="col-sm-6 px-0 d-none d-sm-block">
                        <img src="img/MayoristaGolosina.webp"
                             alt="Login image" class="w-100 vh-100" style="object-fit: cover; object-position: left;">
                    </div>
                </div>
            </div>
        </section>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>