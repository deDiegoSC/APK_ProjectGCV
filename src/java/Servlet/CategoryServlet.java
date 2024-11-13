/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import Entidad.Categoria;
import Mantenimiento.CategoriaDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author DIEGO
 */
@WebServlet(name = "CategoryServlet", urlPatterns = {"/CategoryServlet"})
public class CategoryServlet extends HttpServlet {

    private CategoriaDAO categoriaDAO;

    public void init() {
        categoriaDAO = new CategoriaDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addCategory(request, response);
        } else if ("update".equals(action)) {
            updateCategory(request, response);
        } else if ("delete".equals(action)) {
            deleteCategory(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     *
     * /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void addCategory(HttpServletRequest request, HttpServletResponse response) {
        try {
            String nameCategory = request.getParameter("nameCategory");
            
            Categoria cate = new Categoria();
            cate.setNameCategory(nameCategory);

            if (categoriaDAO.agregarCategoria(cate)) {
                response.sendRedirect("categoryMaintenance.jsp");
            } else {
                response.sendRedirect("categoryMaintenance.jsp?error=true&msg=Error+al+agregar+el+producto");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response) {
        try {
            int idCategory = Integer.parseInt(request.getParameter("idCategory"));
            String nameCategory = request.getParameter("nameCategory");
            Categoria cate = new Categoria(idCategory, nameCategory);

            if (categoriaDAO.actualizarCategoria(cate)) {
                response.sendRedirect("categoryMaintenance.jsp");
            } else {
                response.sendRedirect("categoryMaintenance.jsp?error=true&msg=Error+al+agregar+el+producto");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) {
        try {
            int idCategory = Integer.parseInt(request.getParameter("idCategory"));

            if (categoriaDAO.eliminarCategoria(idCategory)) {
                response.sendRedirect("categoryMaintenance.jsp");
            } else {
                response.sendRedirect("categoryMaintenance.jsp?error=true&msg=Error+al+agregar+el+producto");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
