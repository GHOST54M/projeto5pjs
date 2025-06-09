package bancodedados;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/confirmarReserva")
public class confirmarReserva extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String reservaIdStr = request.getParameter("id");

        if (reservaIdStr != null && !reservaIdStr.isEmpty()) {
            int reservaId = Integer.parseInt(reservaIdStr);

            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                conn = cnx.getConexao();

                // Passo 1: Obter numeroPessoas e restauranteId da reserva
                String selectReservaSQL = "SELECT numero_pessoas, restaurante_id FROM reservas WHERE reserva_id = ?";
                stmt = conn.prepareStatement(selectReservaSQL);
                stmt.setInt(1, reservaId);
                rs = stmt.executeQuery();

                int numeroPessoas = 0;
                int restauranteId = 0;

                if (rs.next()) {
                    numeroPessoas = rs.getInt("numero_pessoas");
                    restauranteId = rs.getInt("restaurante_id");
                } else {
                    response.getWriter().println("Reserva não encontrada.");
                    return;
                }

                rs.close();
                stmt.close();

                // Passo 2: Obter lotação atual do restaurante
                String selectLotacaoSQL = "SELECT lotacao FROM restaurantes WHERE restaurante_id = ?";
                stmt = conn.prepareStatement(selectLotacaoSQL);
                stmt.setInt(1, restauranteId);
                rs = stmt.executeQuery();

                int lotacaoAtual = 0;

                if (rs.next()) {
                    lotacaoAtual = rs.getInt("lotacao");
                } else {
                    response.getWriter().println("Restaurante não encontrado.");
                    return;
                }

                rs.close();
                stmt.close();

                // Passo 3: Atualizar a lotação com o novo valor
                int novaLotacao = lotacaoAtual + numeroPessoas;
                String updateLotacaoSQL = "UPDATE restaurantes SET lotacao = ? WHERE restaurante_id = ?";
                stmt = conn.prepareStatement(updateLotacaoSQL);
                stmt.setInt(1, novaLotacao);
                stmt.setInt(2, restauranteId);
                stmt.executeUpdate();
                stmt.close();

                // Passo 4: Atualizar o status da reserva
                String updateStatusSQL = "UPDATE reservas SET status = ? WHERE reserva_id = ?";
                stmt = conn.prepareStatement(updateStatusSQL);
                stmt.setString(1, "Reserva confirmada aguardando chegada");
                stmt.setInt(2, reservaId);
                int linhasAfetadas = stmt.executeUpdate();

                if (linhasAfetadas > 0) {
                    response.sendRedirect("paginaPrincipalRestaurante.jsp");
                } else {
                    response.getWriter().println("Erro ao confirmar a reserva.");
                }

            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("Erro: " + e.getMessage());
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        } else {
            response.getWriter().println("ID da reserva não informado.");
        }
    }
}
