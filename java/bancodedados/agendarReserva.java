package bancodedados;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.util.Random;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/agendarReserva")
public class agendarReserva extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Recebe os dados do formulário
        int numeroPessoas = Integer.parseInt(request.getParameter("quantidadePessoas"));
        String nomeReserva = request.getParameter("nomeReserva");
        String horarioStr = request.getParameter("horarioReserva");
        String restauranteId = request.getParameter("id");

        // Dados fixos ou gerados
        int clienteId = (int) request.getSession().getAttribute("userId");
        Date dataReserva = Date.valueOf(LocalDate.now());
        Time horarioReserva = Time.valueOf(horarioStr + ":00"); // adiciona os segundos
        String codigoConfirmacao = gerarCodigoConfirmacao();
        String status = "Aguardando a confirmação do restaurante";

        Connection con = null;
        PreparedStatement stmt = null;

        try {
            con = cnx.getConexao(); // Sua classe de conexão
            String sql = "INSERT INTO reservas (cliente_id, restaurante_id, data_reserva, horario_reserva, numero_pessoas, codigo_confirmacao, status, nome_reserva) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, clienteId);
            stmt.setString(2, restauranteId);
            stmt.setDate(3, dataReserva);
            stmt.setTime(4, horarioReserva);
            stmt.setInt(5, numeroPessoas);
            stmt.setString(6, codigoConfirmacao);
            stmt.setString(7, status);
            stmt.setString(8, nomeReserva);
            
            stmt.executeUpdate();

            // Redireciona ou exibe confirmação
            response.sendRedirect("visualizar_reserva.jsp");

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao salvar reserva.");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private String gerarCodigoConfirmacao() {
        Random random = new Random();
        int codigo = 10000000 + random.nextInt(90000000); // 8 dígitos
        return String.valueOf(codigo);
    }
}
