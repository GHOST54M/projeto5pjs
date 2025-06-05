package bancodedados;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class buscarCliente {
	public cliente getClientePorId(int clienteId) throws ClassNotFoundException, SQLException {
        String sql = "SELECT * FROM Clientes WHERE cliente_id = ?";
        cliente cliente = null;

        try (Connection conn = cnx.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, clienteId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    cliente = new cliente();
                    cliente.setId(rs.getInt("cliente_id"));
                    cliente.setNome(rs.getString("nome"));
                    cliente.setTelefone(rs.getString("telefone"));
                    cliente.setEmail(rs.getString("email"));
                }
            }
        }

        return cliente;
    }
}
