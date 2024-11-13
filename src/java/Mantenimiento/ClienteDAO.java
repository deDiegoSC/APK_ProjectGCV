package Mantenimiento;

import Conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Entidad.Cliente;
import Entidad.Empleado;

public class ClienteDAO {

    public boolean agregarCliente(Cliente client) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean resultado = false;

        try {
            conn = Conexion.getConnection();
            String sql = "INSERT INTO cliente (name, lastname, email, phone, address) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, client.getName());
            pstmt.setString(2, client.getLastname());
            pstmt.setString(3, client.getEmail());
            pstmt.setString(4, client.getPhone());
            pstmt.setString(5, client.getAddress());

            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
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

    public boolean actualizarCliente(Cliente client) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean resultado = false;

        try {
            conn = Conexion.getConnection();
            String sql = "UPDATE cliente SET name = ?, lastname = ?, email = ?, "
                    + "phone = ?, address = ? WHERE idClient = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, client.getName());
            pstmt.setString(2, client.getLastname());
            pstmt.setString(3, client.getEmail());
            pstmt.setString(4, client.getPhone());
            pstmt.setString(5, client.getAddress());
            pstmt.setInt(6, client.getIdClient());

            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
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

    public boolean eliminarCliente(int ClienteId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean resultado = false;

        try {
            conn = Conexion.getConnection();
            String sql = "DELETE FROM cliente WHERE idClient = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, ClienteId);

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

    public List<Cliente> listarClientes() {
        List<Cliente> listaClientes = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = Conexion.getConnection();
            String sql = "SELECT * FROM cliente";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Cliente client = new Cliente();
                client.setIdClient(rs.getInt("idClient"));
                client.setName(rs.getString("name"));
                client.setLastname(rs.getString("lastname"));
                client.setEmail(rs.getString("email"));
                client.setPhone(rs.getString("phone"));
                client.setAddress(rs.getString("address"));
                listaClientes.add(client);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
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

        return listaClientes;
    }

    public List<Cliente> listarClientesNomDni(String dato) {
        List<Cliente> listaClientes = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = Conexion.getConnection();
            String sql = "SELECT * FROM client  WHERE name=? OR DNI= ?;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dato);
            pstmt.setString(2, dato);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                Cliente client = new Cliente();
                client.setIdClient(rs.getInt("idClient"));
                client.setName(rs.getString("name"));
                client.setLastname(rs.getString("lastname"));
                client.setEmail(rs.getString("email"));
                client.setPhone(rs.getString("phone"));
                client.setAddress(rs.getString("address"));
                listaClientes.add(client);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
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

        return listaClientes;
    }

    public Cliente BuscarClienteID(int idClient) {
        Cliente objCliente = null;
        String sql = "SELECT * FROM client WHERE idClient = ?";
        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idClient);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    objCliente = new Cliente();
                    objCliente.setIdClient(rs.getInt("idClient"));
                    objCliente.setName(rs.getString("name"));
                    objCliente.setLastname(rs.getString("lastname"));
                    objCliente.setEmail(rs.getString("email"));
                    objCliente.setPhone(rs.getString("phone"));
                    objCliente.setAddress(rs.getString("address"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return objCliente;
    }

    public int validarClient(Empleado c) {
        int r = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = Conexion.getConnection();
            String sql = "SELECT * FROM employee where username=? and password=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, c.getUsername());
            pstmt.setString(2, c.getUsername());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                r = r + 1;
                c.setName(rs.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
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
        if (r == 1) {
            return 1;
        } else {
            return 0;
        }
    }

    public int obtenerId(Empleado c) {
        int idClient = -1;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = Conexion.getConnection();
            String sql = "SELECT idEmployee FROM employee WHERE username = ? AND password = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, c.getUsername());
            pstmt.setString(2, c.getPassword());
            rs = pstmt.executeQuery();

            if (rs.next()) {
                idClient = rs.getInt("idEmployee");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
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

        return idClient;
    }
}
