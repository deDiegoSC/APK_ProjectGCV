/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import Entidad.Cliente;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Mantenimiento.ClienteDAO;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;

/**
 *
 * @author DIEGO
 */
@WebServlet(name = "ClienteServlet", urlPatterns = {"/ClienteServlet"})
public class ClienteServlet extends HttpServlet {

    private ClienteDAO clienteDAO;
    private Cliente c = new Cliente();
    int r;

    public void init() {
        clienteDAO = new ClienteDAO();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("accion");
        if ("signoutClient".equals(action)) {
            signoutClient(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no soportada");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addClient(request, response);
        } else if ("update".equals(action)) {
            updateClient(request, response);
        } else if ("delete".equals(action)) {
            deleteClient(request, response);
        } else if ("loginClient".equals(action)) {
            loginClient(request, response);
        } else if ("registerClient".equals(action)) {
            registerClient(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void addClient(HttpServletRequest request, HttpServletResponse response) {
        try {
            String name = request.getParameter("name");
            String lastname = request.getParameter("lastname");
            String email = (String) request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String password = request.getParameter("password");
            Cliente client = new Cliente();
            client.setName(name);
            client.setLastname(lastname);
            client.setEmail(email);
            client.setPhone(phone);
            client.setAddress(address);
            client.setPassword(password);
            if (clienteDAO.agregarCliente(client)) {
                response.sendRedirect("clientMaintenance.jsp");
            } else {
                response.sendRedirect("clientMaintenance.jsp?error=true&msg=Error+al+agregar+el+cliente");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void updateClient(HttpServletRequest request, HttpServletResponse response) {
        try {
            int idClient = Integer.parseInt(request.getParameter("idClient"));
            String name = request.getParameter("name");
            String lastname = request.getParameter("lastname");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            Cliente client = new Cliente();
            client.setIdClient(idClient);
            client.setName(name);
            client.setLastname(lastname);
            client.setEmail(email);
            client.setPhone(phone);
            client.setAddress(address);
            if (clienteDAO.actualizarCliente(client)) {
                response.sendRedirect("clientMaintenance.jsp");
            } else {
                response.sendRedirect("clientMaintenance.jsp?error=true&msg=Error+al+agregar+el+cliente");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void deleteClient(HttpServletRequest request, HttpServletResponse response) {
        int idClient = Integer.parseInt(request.getParameter("idClient"));
        try {
            if (clienteDAO.eliminarCliente(idClient)) {
                response.sendRedirect("clientMaintenance.jsp");
            } else {
                response.sendRedirect("clientMaintenance.jsp?error=true&msg=Error+al+agregar+el+producto");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void loginClient(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String Correo = request.getParameter("email");
        String Contra = request.getParameter("password");
        c.setEmail(Correo);
        c.setPassword(Contra);
        r = clienteDAO.validarClient(c);
        if (r == 1) {
            HttpSession session = request.getSession();
            session.setAttribute("correo", Correo);
            session.setAttribute("nomC", c.getName());
            session.setAttribute("idC", clienteDAO.obtenerId(c));
            response.sendRedirect(request.getContextPath() + "/WebPageForClient/WebPage.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/WebPageForClient/loginClient.jsp?error=true&msg=Error+al+agregar+el+producto");
        }
    }

    private void registerClient(HttpServletRequest request, HttpServletResponse response) {
        String name = request.getParameter("name");
        String lastname = request.getParameter("lastname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        c.setName(name);
        c.setLastname(lastname);
        c.setEmail(email);
        c.setPhone(phone);
        c.setAddress(address);
        c.setPassword(password);
    }

    private void signoutClient(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/WebPageForClient/WebPage.jsp");
    }

}
