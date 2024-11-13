package Mantenimiento;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Entidad.Categoria;
import Conexion.Conexion;

public class CategoriaDAO {

    public static List<Categoria> listarCategorias() throws SQLException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Categoria> categorias = new ArrayList<>();
        try {
            con = Conexion.getConnection();
            String sql = "SELECT * FROM category";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setIdCategory(rs.getInt("idCategory"));
                categoria.setNameCategory(rs.getString("nameCategory"));
                categorias.add(categoria);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return categorias;
    }

    public boolean agregarCategoria(Categoria categoria) {
        boolean resultado = false;

        String sql = "INSERT INTO category (nameCategory) VALUES (?)";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, categoria.getNameCategory());

            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                resultado = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return resultado;
    }

    public static String obtenerNombreCategoria(int idCategory) throws SQLException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String nombreCategoria = null;
        try {
            con = Conexion.getConnection();
            String sql = "SELECT nameCategory FROM category WHERE idCategory = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, idCategory);
            rs = ps.executeQuery();
            if (rs.next()) {
                nombreCategoria = rs.getString("nameCategory");
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return nombreCategoria;
    }

    public boolean actualizarCategoria(Categoria categoria) {
        boolean resultado = false;

        String sql = "UPDATE category SET nameCategory = ? WHERE idCategory = ?";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, categoria.getNameCategory());
            pstmt.setInt(2, categoria.getIdCategory());

            int rowsUpdated = pstmt.executeUpdate();
            resultado = rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println("Error during actualizarProducto: " + e.getMessage());
            e.printStackTrace();
        }
        return resultado;
    }

    public boolean eliminarCategoria(int categoryId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean resultado = false;

        try {
            conn = Conexion.getConnection();
            String sql = "DELETE FROM category WHERE idCategory = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, categoryId);

            int rowsDeleted = pstmt.executeUpdate();
            if (rowsDeleted > 0) {
                resultado = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        return resultado;
    }
}
