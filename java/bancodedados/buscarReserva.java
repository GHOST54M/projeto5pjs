package bancodedados;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class buscarReserva {
    public List<reserva> listarReservasDoCliente(int clienteId) throws SQLException, ClassNotFoundException {
        List<reserva> reservas = new ArrayList<>();

        String sql = """
            SELECT 
                r.reserva_id, r.cliente_id, r.restaurante_id, r.data_reserva, 
                r.horario_reserva, r.numero_pessoas, r.codigo_confirmacao, 
                r.status, r.nome_reserva,
                rest.nome AS nome_restaurante, rest.rua, rest.numero AS numero_rest, rest.cep
            FROM reservas r
            INNER JOIN restaurantes rest ON r.restaurante_id = rest.restaurante_id
            WHERE r.cliente_id = ?
        """;

        try (Connection con = cnx.getConexao();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, clienteId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    reserva r = new reserva();
                    r.setReservaId(rs.getInt("reserva_id"));
                    r.setClienteId(rs.getInt("cliente_id"));
                    r.setRestauranteId(rs.getInt("restaurante_id"));
                    r.setDataReserva(rs.getDate("data_reserva"));
                    r.setHorarioReserva(rs.getTime("horario_reserva"));
                    r.setNumeroPessoas(rs.getInt("numero_pessoas"));
                    r.setCodigoConfirmacao(rs.getString("codigo_confirmacao"));
                    r.setStatus(rs.getString("status"));
                    r.setNomeReserva(rs.getString("nome_reserva"));

                    // Informações do restaurante (presume que sua classe reserva tenha esses campos ou um objeto Restaurante)
                    r.setNomeRestaurante(rs.getString("nome_restaurante"));
                    r.setRuaRestaurante(rs.getString("rua"));
                    r.setNumeroRestaurante(rs.getString("numero_rest"));
                    r.setCepRestaurante(rs.getString("cep"));

                    reservas.add(r);
                }
            }
        }

        return reservas;
    }
}

