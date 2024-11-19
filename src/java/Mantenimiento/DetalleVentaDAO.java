/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Mantenimiento;

import Conexion.Conexion;
import Entidad.DetalleVenta;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author DIEGO
 */
public class DetalleVentaDAO {
    public void addDT(DetalleVenta dv) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = Conexion.getConnection();
            String sql = "INSERT INTO saledetail (idSale, idProduct, amount, price, discount) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, dv.getIdSale());
            pstmt.setInt(2, dv.getIdProduct());
            pstmt.setInt(3, dv.getAmount());
            pstmt.setDouble(4, dv.getPrice());
            pstmt.setDouble(5, 0.00);

            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("Detalle de venta insertado correctamente.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
