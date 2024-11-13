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

@WebServlet(name = "AddProductServlet", urlPatterns = {"/AddProductServlet"})
public class AddProductServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            String nameProduct = request.getParameter("nameProduct");
            String description = request.getParameter("description");
            String img = request.getParameter("img");
            String categoryStr = request.getParameter("category");
            String stockStr = request.getParameter("stock");
            String priceStr = request.getParameter("price");
            if (nameProduct == null || description == null || img == null || categoryStr == null || stockStr == null || priceStr == null) {
                response.sendRedirect("productMaintenance.jsp?error=true&msg=Campos+faltantes");
                return;
            }
            int stock;
            double price;
            try {
                stock = Integer.parseInt(stockStr);
                price = Double.parseDouble(priceStr);
                if (stock < 0) {
                    response.sendRedirect("productMaintenance.jsp?error=true&msg=Stock+no+puebe+ser+negativo");
                    return;
                }

                if (price < 0) {
                    response.sendRedirect("productMaintenance.jsp?error=true&msg=Precio+no+puebe+ser+negativo");
                    return;
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("productMaintenance.jsp?error=true&msg=Formato+de+stock+o+precio+incorrecto");
                return;
            }
            int category;
            try {
                category = Integer.parseInt(categoryStr);
            } catch (NumberFormatException e) {
                response.sendRedirect("productMaintenance.jsp?error=true&msg=Categoría+incorrecta");
                return;
            }
            Productos producto = new Productos();
            producto.setNameProduct(nameProduct);
            producto.setStock(stock);
            producto.setPrice(price);
            producto.setDescription(description);
            producto.setIdCategory(category);
            producto.setImg(img);
            ProductoDAO productoDAO = new ProductoDAO();
            boolean resultado = productoDAO.agregarProducto(producto);
            if (resultado) {
                response.sendRedirect("productMaintenance.jsp");
            } else {
                response.sendRedirect("productMaintenance.jsp?error=true&msg=Error+al+agregar+el+producto");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("productMaintenance.jsp?error=true&msg=Error+inesperado");
        }
    }
}