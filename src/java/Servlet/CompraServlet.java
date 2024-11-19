/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import Entidad.DetalleVenta;
import Mantenimiento.ProductoDAO;
import Servlet.CartServlet;
import Servlet.CartServlet.Producto;
import Entidad.Productos;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Entidad.Venta;
import Mantenimiento.DetalleVentaDAO;
import Mantenimiento.VentaDAO;
import java.text.ParseException;
import java.util.Date;
import java.text.SimpleDateFormat;
import javax.servlet.annotation.WebServlet;

/**
 *
 * @author DIEGO
 */
@WebServlet(name = "CompraServlet", urlPatterns = {"/CompraServlet"})
public class CompraServlet extends HttpServlet {

    Venta v = new Venta();
    VentaDAO vdao = new VentaDAO();
    Date fechaActual = new Date();
    DetalleVenta dv = new DetalleVenta();
    DetalleVentaDAO dvdao = new DetalleVentaDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<CartServlet.Producto> carrito = (List<CartServlet.Producto>) request.getSession().getAttribute("carrito");
        boolean status = true;
        ProductoDAO dao = new ProductoDAO();
        double total = 0;
        for (Producto product : carrito) {
            int cant = dao.obtenerCant(product.getId());
            System.out.println("CANTIDAD DE id"+product.getId()+ " y su cantidad es:"+product.getCantidad());
            total += product.getPrecio();
            if (product.getCantidad() > cant) {
                request.getSession().removeAttribute("carrito");
                response.sendRedirect(request.getContextPath() + "/WebPageForClient/WebPage.jsp");
                return;
            }
        }

        for (Producto products : carrito) {
            System.out.println("EN LA PARTE DE PAGAR REVISAR ID DE LOS PRODUCTOS QUE ESTAN EN EL CARRITO"
                    + " id:"+products.getId());
            boolean Up = dao.UpStock(products.getId(), products.getCantidad());
            if(Up){
                System.out.println("Si hay stock");
            }else
                System.out.println("No hay stock");
                
            try {
                //AGREGANDO VENTA
                int idC = (Integer) request.getSession().getAttribute("idC");
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String formattedDate = formatter.format(fechaActual);
                v.setIdClient(idC);
                v.setTotalPrice(total);
                v.setDate(formatter.parse(formattedDate));
                vdao.addVenta(v);
                //AGREGANDO DETALLE VENTA
                for(Producto produc:carrito)
                {
                    int Idv=vdao.ultimoId();
                    int idP=produc.getId();
                    int cant=produc.getCantidad();
                    double precio=produc.getSubtotal();
                    dv.setIdSale(Idv);
                    dv.setIdProduct(idP);
                    dv.setAmount(cant);
                    dv.setPrice(precio);
                    dvdao.addDT(dv);
                }
                
                
            } catch (ParseException e) {
                System.err.println("Error al parsear la fecha: " + e.getMessage());
            }
            if (!Up) {
                status = false;
            }
        }
        if (status) {
            
            request.getSession().removeAttribute("carrito");
            request.getSession().setAttribute("exito", true);
        } else {
            
            request.getSession().setAttribute("exito", false);
        }

        response.sendRedirect("WebPageForClient/confirmacion.jsp");

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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
