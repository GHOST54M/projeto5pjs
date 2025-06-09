package bancodedados;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class buscarReservaPoraRestaurante {
    public List<reserva> listarReservasPorRestaurante(int restauranteId) throws SQLException {
        List<reserva> reservas = new ArrayList<>();

        String sql = "SELECT * FROM reservas  WHERE restaurante_id = ?";
        try (Connection conn = cnx.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, restauranteId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                reserva reserva = new reserva();
                reserva.setReservaId(rs.getInt("reserva_id"));
                reserva.setClienteId(rs.getInt("cliente_id"));
                reserva.setRestauranteId(rs.getInt("restaurante_id"));
                reserva.setDataReserva(rs.getDate("data_reserva"));
                reserva.setHorarioReserva(rs.getTime("horario_reserva"));
                reserva.setNumeroPessoas(rs.getInt("numero_pessoas"));
                reserva.setCodigoConfirmacao(rs.getString("codigo_confirmacao"));
                reserva.setStatus(rs.getString("status"));
                reserva.setNomeReserva(rs.getString("nome_reserva"));

                reservas.add(reserva);
            }
        } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        return reservas;
    }
}
