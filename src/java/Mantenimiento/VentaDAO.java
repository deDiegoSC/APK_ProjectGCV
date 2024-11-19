/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Mantenimiento;

import Conexion.Conexion;
import Entidad.DetalleVenta;
import Entidad.Venta;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author DIEGO
 */
public class VentaDAO {

    public void addVenta(Venta v) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = Conexion.getConnection();
            String sql = "INSERT INTO sale (idClient, totalPrice, date) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, v.getIdClient());
            Timestamp timestamp = new Timestamp(v.getDate().getTime());
            pstmt.setDouble(2, v.getTotalPrice());
            pstmt.setTimestamp(3, timestamp);

            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("Venta insertada correctamente.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public List<DetalleVenta> getDetalleVentasByIdVenta(int idVenta) {
        List<DetalleVenta> detalleVentas = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = Conexion.getConnection();
            String sql = "SELECT sd.idSaleDetail, sd.idSale, sd.idProduct, sd.amount, sd.price, sd.discount, p.nameProduct as nameProduct "
                    + "FROM saledetail sd "
                    + "JOIN product p ON sd.idProduct = p.idproduct "
                    + "WHERE sd.idSale = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idVenta);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                DetalleVenta detalleVenta = new DetalleVenta();
                detalleVenta.setIdSaleDetail(rs.getInt("idDetalleVenta"));
                detalleVenta.setIdSale(rs.getInt("idVenta"));
                detalleVenta.setIdProduct(rs.getInt("idProducto"));
                detalleVenta.setAmount(rs.getInt("cantidad"));
                detalleVenta.setPrice(rs.getDouble("precioVenta"));
                detalleVenta.setDiscount(rs.getDouble("descuento"));
                detalleVenta.setProductName(rs.getString("nombreProducto")); // Set the product name

                detalleVentas.add(detalleVenta);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return detalleVentas;
    }

    public List<Venta> getVentaCliente(int idCliente) {
        List<Venta> ventas = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = Conexion.getConnection();
            String sql = "SELECT * FROM sale WHERE idClient = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, (idCliente));

            rs = pstmt.executeQuery();

            while (rs.next()) {
                Venta venta = new Venta();
                venta.setIdSale(rs.getInt("idVenta"));
                venta.setIdClient(rs.getInt("idCliente"));
                venta.setDate(rs.getTimestamp("fechaVenta"));
                venta.setTotalPrice(rs.getDouble("totalVenta"));

                // Get sale details
                List<DetalleVenta> detalles = getDetalleVentasByIdVenta(venta.getIdSale());
                venta.setDetalles(detalles);

                ventas.add(venta);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ventas;
    }

    public int ultimoId() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int ultimoId = 0;
        try {
            conn = Conexion.getConnection();
            String sql = "SELECT MAX(idSale) AS ultimo_id FROM sale";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery(sql);

            if (rs.next()) {
                ultimoId = rs.getInt("ultimo_id");
            } else {
                System.out.println("No se encontraron ventas");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ultimoId;
    }
}
