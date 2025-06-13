package bancodedados;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class buscarRestaurante {
	public restaurante getRestaurantePorId(int restauranteId) throws ClassNotFoundException, SQLException {
        String sql = "SELECT * FROM restaurantes WHERE restaurante_Id = ?";
        restaurante restaurante = null;

        try (Connection conn = cnx.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, restauranteId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	restaurante = new restaurante(
                		    rs.getInt("restaurante_id"),
                		    rs.getString("nome"),
                		    rs.getInt("capacidade_maxima"),
                		    rs.getInt("lotacao"),
                		    rs.getInt("max_reserva"),
                		    rs.getString("especialidade_gastronomica"),
                		    rs.getString("email"),
                		    rs.getString("cnpj"),
                		    rs.getString("municipio"),
                		    rs.getString("uf"),
                		    rs.getString("rua"),
                		    rs.getInt("numero"),
                		    rs.getInt("cep"),
                		    rs.getString("descricao"),
                		    rs.getString("telefone1"),
                		    rs.getString("telefone2"),
                		    rs.getString("foto_perfil")
                		);

                }
            }
        }

        return restaurante;
    }
}
