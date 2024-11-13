package Servlet;

import Entidad.Productos;
import Mantenimiento.ProductoDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "updateProductServlet" , urlPatterns="/updateProductServlet")
public class updateProductServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Debugging output
            System.out.println("Retrieving parameters from request");

            int idProducto = Integer.parseInt(request.getParameter("idProduct"));
            String nameProduct = request.getParameter("nameProduct");
            int stock = Integer.parseInt(request.getParameter("stock"));
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");
            int category = Integer.parseInt(request.getParameter("category"));
            String img = request.getParameter("img");

            // Print parameters for debugging
            System.out.println("ID Producto: " + idProducto);
            System.out.println("Nombre Producto: " + nameProduct);
            System.out.println("Stock Producto: " + stock);
            System.out.println("Precio Producto: " + price);
            System.out.println("Descripción Producto: " + description);
            System.out.println("Categoría Producto: " + category);
            System.out.println("Imagen Producto: " + img);

            Productos producto = new Productos();
            producto.setIdProduct(idProducto);
            producto.setNameProduct(nameProduct);
            producto.setStock(stock);
            producto.setPrice(price);
            producto.setDescription(description);
            producto.setIdCategory(category);
            producto.setImg(img);

            ProductoDAO productoDAO = new ProductoDAO();
            boolean resultado = productoDAO.actualizarProducto(producto);

            if (resultado) {
                response.sendRedirect("productMaintenance.jsp");
            } else {
                response.sendRedirect("productMaintenance.jsp?error=true");
            }
        } catch (Exception e) {
            e.printStackTrace(out);
            response.sendRedirect("productMaintenance.jsp?error=true");
        } finally {
            out.close();
        }
    }
}