
package Servlet;

import Mantenimiento.ProductoDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name="deleteProductServlet",urlPatterns="/deleteProductServlet")
public class deleteProductServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productoId = Integer.parseInt(request.getParameter("productoId"));

        ProductoDAO productoDAO = new ProductoDAO();
        boolean resultado = productoDAO.eliminarProducto(productoId);

        if (resultado) {
            response.sendRedirect("productMaintenance.jsp");
        } else {
            response.sendRedirect("productMaintenance.jsp?error=true");
        }
    }
}