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

/**
 *
 * @author DIEGO
 */
@WebServlet(name = "ClienteServlet", urlPatterns = {"/ClienteServlet"})
public class ClienteServlet extends HttpServlet {

    private ClienteDAO clienteDAO;

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addClient(request, response);
        } else if ("update".equals(action)) {
            updateClient(request, response);
        } else if ("delete".equals(action)) {
            deleteClient(request, response);
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
            String email = (String)request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            Cliente client = new Cliente();
            client.setName(name);
            client.setLastname(lastname);
            client.setEmail(email);
            client.setPhone(phone);
            client.setAddress(address);
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

}
