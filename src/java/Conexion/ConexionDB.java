/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author DIEGO
 */
public class ConexionDB {

    private static final String URL = "jdbc:mysql://localhost:3306/APR_PF";
    private static final String USUARIO = "root";
    private static final String CONTRASEÑA = "";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USUARIO, CONTRASEÑA);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Controlador JDBC no encontrado");
        }
    }

}
