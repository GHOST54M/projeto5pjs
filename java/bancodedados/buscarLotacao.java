package bancodedados;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class buscarLotacao {

    public restaurante obterLotacaoPorRestauranteId(int restauranteId) throws SQLException {
        restaurante restaurante = null;

        String sql = "SELECT restaurante_id, capacidade_maxima, lotacao FROM restaurantes WHERE restaurante_id = ?";

        try (Connection conn = cnx.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, restauranteId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int capacidade = rs.getInt("capacidade_maxima");
                int lotacao = rs.getInt("lotacao");

                // Apenas campos usados neste caso
                restaurante = new restaurante(restauranteId, null, capacidade, lotacao, 0, null, null, null,
                                              null, null, null, 0, 0, null, null, null, null);
            }
        } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        return restaurante;
    }
}
