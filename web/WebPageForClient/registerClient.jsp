<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Inicio de Sesión</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../CSS/StyleLogin.css">
    </head>
    <body>
        <section class="vh-100">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-6 px-0 d-none d-sm-block">
                        <img src="../img/MayoristaGolosina.webp"
                             alt="Login image" class="w-100 vh-100" style="object-fit: cover; object-position: left;">
                    </div>
                    <div class="col-sm-6 text-black">

                        <div class="px-5">
                            <i class="fas fa-crow fa-2x me-3 pt-5 mt-xl-4" style="color: #709085;"></i>
                            <span class="h1 fw-bold mb-0">Mayoristas APK</span>
                            <hr>
                            <img src="../img/APKnoDesign.png" style="witdh:200px; height: 400px">
                        </div>

                        <div class="h-custom-2 px-5 ms-xl-4 pt-xl-0 mt-xl-n5" >

                            <form action="<%= request.getContextPath()%>/ClienteServlet" method="post" style="width: 23rem;">
                                <input type="hidden" name="action" value="registerClient">
                                <h2 class="fw-bold mb-3 pb-3" style="letter-spacing: 1px;">Registrar Cliente</h2>
                                
                                <div class="form-outline mb-4">
                                    <input type="text" id="name" name="name" class="form-control form-control-lg" required/>
                                    <label class="form-label" for="name">Nombre completo</label>
                                </div>
                                
                                <div class="form-outline mb-4">
                                    <input type="text" id="lastname" name="lastname" class="form-control form-control-lg" required/>
                                    <label class="form-label" for="lastname">Apellidos</label>
                                </div>
                                
                                <div class="form-outline mb-4">
                                    <input type="email" id="email" name="email" class="form-control form-control-lg" required/>
                                    <label class="form-label" for="email">Correo</label>
                                </div>
                                
                                <div class="form-outline mb-4">
                                    <input type="tel" id="phone" name="phone" class="form-control form-control-lg" required/>
                                    <label class="form-label" for="phone">Telefono</label>
                                </div>
                                
                                <div class="form-outline mb-4">
                                    <input type="text" id="address" name="address" class="form-control form-control-lg" required/>
                                    <label class="form-label" for="address">Direccion</label>
                                </div>

                                <div class="form-outline mb-4">
                                    <input type="password" class="form-control form-control-lg" id="contrasena" name="contrasena" required/>
                                    <label class="form-label" for="contrasena">Contraseña</label>
                                </div>

                                <div class="pt-1 mb-4">
                                    <button class="btn btn-info btn-lg btn-block" type="submit">Registrar</button>
                                </div>
                                <div class="text-center">
                                    <p>Ya esta registrado? <a href="loginClient.jsp">Ingrese</a></p>
                                </div>
                            </form>

                        </div>

                    </div>

                </div>
            </div>
        </section>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>