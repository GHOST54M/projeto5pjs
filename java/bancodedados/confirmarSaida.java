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

@WebServlet("/confirmarSaida")
public class confirmarSaida extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String reservaId = request.getParameter("reservaId");
        System.out.println("reservaId recebido: '" + reservaId + "'");

        Connection con = null;
        PreparedStatement psReserva = null;
        PreparedStatement psUpdate = null;
        PreparedStatement psDelete = null;
        ResultSet rs = null;

        try {
            con = cnx.getConexao();

            // 1. Obter numero_pessoas e restaurante_id da reserva
            String sqlReserva = "SELECT numero_pessoas, restaurante_id FROM reservas WHERE reserva_id = ?";
            psReserva = con.prepareStatement(sqlReserva);
            psReserva.setString(1, reservaId);
            rs = psReserva.executeQuery();

            if (rs.next()) {
                int numeroPessoas = rs.getInt("numero_pessoas");
                int restauranteId = rs.getInt("restaurante_id");

                // 2. Atualizar a lotacao do restaurante
                String sqlUpdate = "UPDATE restaurantes SET lotacao = lotacao - ? WHERE restaurante_id = ?";
                psUpdate = con.prepareStatement(sqlUpdate);
                psUpdate.setInt(1, numeroPessoas);
                psUpdate.setInt(2, restauranteId);
                psUpdate.executeUpdate();

                // 3. Excluir a reserva da tabela
                String sqlDelete = "DELETE FROM reservas WHERE reserva_id = ?";
                psDelete = con.prepareStatement(sqlDelete);
                psDelete.setString(1, reservaId);
                psDelete.executeUpdate();
            }

            response.sendRedirect("paginaPrincipalRestaurante.jsp"); // página de confirmação
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("erro.jsp"); // página de erro
        } finally {
            try {
                if (rs != null) rs.close();
                if (psReserva != null) psReserva.close();
                if (psUpdate != null) psUpdate.close();
                if (psDelete != null) psDelete.close();
                if (con != null) con.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
