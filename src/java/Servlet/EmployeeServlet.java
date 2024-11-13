package Servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import Mantenimiento.EmpleadoDAO;
import Entidad.Empleado;
import javax.servlet.http.HttpSession;

@WebServlet(name = "EmployeeServlet", urlPatterns = {"/EmployeeServlet"})
public class EmployeeServlet extends HttpServlet {

    private EmpleadoDAO adminDAO;

    public void init() {
        adminDAO = new EmpleadoDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register".equals(action)) {
            registerAdmin(request, response);
        } else if ("login".equals(action)) {
            loginAdmin(request, response);
        } else if ("signout".equals(action)) {
            signOut(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("signout".equals(action)) {
            signOut(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Método no permitido");
        }
    }

    private void registerAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String name = request.getParameter("name");
        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        Empleado admin = new Empleado();
        admin.setName(name);
        admin.setUsername(usuario);
        admin.setPassword(contrasena);

        try {
            if (adminDAO.registerAdmin(admin)) {
                response.sendRedirect("index.jsp");
            } else {
                response.sendRedirect("registerEmployee.jsp");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void loginAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        try {
            Empleado admin = adminDAO.loginAdmin(usuario, contrasena);
            if (admin != null) {
                HttpSession session = request.getSession(true);
                session.setAttribute("admin", admin);
                session.setAttribute("nameEmployee", admin.getName());
                response.sendRedirect("productMaintenance.jsp");
            } else {
                response.sendRedirect("index.jsp");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void signOut(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}
