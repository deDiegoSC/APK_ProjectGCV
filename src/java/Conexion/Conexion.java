package Conexion; 
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    private static final String URL = "jdbc:mysql://localhost:3306/apk";
    private static final String USUARIO = "root";
    private static final String CONTRASEÑA = "";

   
    public static Connection getConnection() throws SQLException {
        try {
           
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Retorna la conexión
            return DriverManager.getConnection(URL, USUARIO, CONTRASEÑA);
        } catch (ClassNotFoundException ex) {
            throw new SQLException("Controlador JDBC no encontrado", ex);
        }
    }
}