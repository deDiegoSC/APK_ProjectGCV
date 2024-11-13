package Mantenimiento;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import Entidad.Empleado;
import Conexion.Conexion;

public class EmpleadoDAO {

    private static final String INSERT_USER_SQL = "INSERT INTO employee (name,username, password) VALUES (?, ?, ?)";
    private static final String SELECT_USER_BY_USERNAME_AND_PASSWORD = "SELECT idEmployee, name,username, password FROM employee WHERE username = ? AND password = ?";

    public boolean registerAdmin(Empleado admin) throws SQLException {
        try (Connection connection = Conexion.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER_SQL)) {
            preparedStatement.setString(1, admin.getName());
            preparedStatement.setString(2, admin.getUsername());
            preparedStatement.setString(3, admin.getPassword());
            return preparedStatement.executeUpdate() > 0;
        }
    }

    public Empleado loginAdmin(String username, String password) throws SQLException {
        try (Connection connection = Conexion.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_USERNAME_AND_PASSWORD)) {
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                return new Empleado(rs.getInt("idEmployee"), rs.getString("name"), rs.getString("username"), rs.getString("password"));
            }
        }
        return null;
    }
}
