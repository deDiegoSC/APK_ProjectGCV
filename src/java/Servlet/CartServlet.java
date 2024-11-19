package Servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "CartServlet", urlPatterns = {"/CartServlet"})
public class CartServlet extends HttpServlet {

    //private List<Producto> carrito = new ArrayList<>();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        try {
            Integer id = Integer.valueOf(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            String imagen = request.getParameter("imagen");
            Integer cantidad = Integer.valueOf(request.getParameter("cantidad"));
            Double precio = Double.valueOf(request.getParameter("precio"));
            Double subtotal = cantidad * precio;

            List<Producto> carrito = (List<Producto>) request.getSession().getAttribute("carrito");

            boolean productoExistente = false;
            if (carrito != null) {
                for (Producto producto : carrito) {
                    if (producto.getId().equals(id)) {
                        // Actualizar la cantidad del producto existente
                        producto.setCantidad(producto.getCantidad() + cantidad);
                        producto.setSubtotal(producto.getPrecio() * producto.getCantidad());
                        productoExistente = true;
                        break;
                    }
                }
            } else {
                carrito = new ArrayList<>();
            }

            if (!productoExistente) {
                Producto producto = new Producto(id, nombre, imagen, cantidad, precio, subtotal);
                carrito.add(producto);
            }

            request.getSession().setAttribute("carrito", carrito);
            response.sendRedirect("WebPageForClient/confirmacion.jsp");

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameters");
            System.out.println(e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }   

    public static class Producto {

        private Integer id;
        private String nombre;
        private String imagen;
        private Integer cantidad;
        private Double precio;
        private Double subtotal;

        public Producto() {
        }

        public Producto(Integer id, String nombre, String imagen, Integer cantidad, Double precio, Double subtotal) {
            this.id = id;
            this.nombre = nombre;
            this.imagen = imagen;
            this.cantidad = cantidad;
            this.precio = precio;
            this.subtotal = subtotal;
        }

        public Integer getId() {
            return id;
        }

        public void setId(Integer id) {
            this.id = id;
        }

        public String getNombre() {
            return nombre;
        }

        public void setNombre(String nombre) {
            this.nombre = nombre;
        }

        public String getImagen() {
            return imagen;
        }

        public void setImagen(String imagen) {
            this.imagen = imagen;
        }

        public Integer getCantidad() {
            return cantidad;
        }

        public void setCantidad(Integer cantidad) {
            this.cantidad = cantidad;
        }

        public Double getPrecio() {
            return precio;
        }

        public void setPrecio(Double precio) {
            this.precio = precio;
        }

        public Double getSubtotal() {
            return subtotal;
        }

        public void setSubtotal(Double subtotal) {
            this.subtotal = subtotal;
        }
    }
}