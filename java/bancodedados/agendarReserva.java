package bancodedados;

import java.io.IOException;
import java.sql.*;
import java.time.*;
import java.util.Random;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/agendarReserva")
public class agendarReserva extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int numeroPessoas = Integer.parseInt(request.getParameter("quantidadePessoas"));
        String nomeReserva = request.getParameter("nomeReserva");
        String horarioStr = request.getParameter("horarioReserva");
        String restauranteId = request.getParameter("id");

        int clienteId = (int) request.getSession().getAttribute("userId");
        LocalDate dataHoje = LocalDate.now();
        Date dataReserva = Date.valueOf(dataHoje);
        Time horarioReserva = Time.valueOf(horarioStr + ":00");
        String codigoConfirmacao = gerarCodigoConfirmacao();
        String status = "Aguardando a confirmação do restaurante";

        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            con = cnx.getConexao();

            String checkSql = "SELECT COUNT(*) FROM reservas WHERE cliente_id = ? AND data_reserva = ?";
            stmt = con.prepareStatement(checkSql);
            stmt.setInt(1, clienteId);
            stmt.setDate(2, dataReserva);
            rs = stmt.executeQuery();

         // Verifica se o cliente já tem reserva no dia
            if (rs.next() && rs.getInt(1) > 0) {
                request.setAttribute("erroReserva", "Você já possui uma reserva registrada para hoje.");
                request.getRequestDispatcher("detalhesRestaurante.jsp?id=" + restauranteId).forward(request, response);
                return;
            }

            stmt.close();
            rs.close();

            // Verifica se o horário da reserva está dentro do horário de funcionamento
            String tipoDia = obterTipoDia(dataHoje.getDayOfWeek());
            String horarioSql = "SELECT hora_abertura, hora_fechamento FROM horarios_funcionamento "
                              + "WHERE restaurante_id = ? AND dia_semana = ?";
            stmt = con.prepareStatement(horarioSql);
            stmt.setString(1, restauranteId);
            stmt.setString(2, tipoDia);
            rs = stmt.executeQuery();

            if (rs.next()) {
                Time horaAbertura = rs.getTime("hora_abertura");
                Time horaFechamento = rs.getTime("hora_fechamento");

                if (horarioReserva.before(horaAbertura) || horarioReserva.after(horaFechamento)) {
                    request.setAttribute("erroHorario", "O horário selecionado está fora do horário de funcionamento do restaurante.");
                    request.getRequestDispatcher("detalhesRestaurante.jsp?id=" + restauranteId).forward(request, response);
                    return;
                }
            } else {
                // Se não encontrou horário para o tipo de dia assume que o restaurante não funciona
                request.setAttribute("erroHorario", "O restaurante está fechado.");
                request.getRequestDispatcher("detalhesRestaurante.jsp?id=" + restauranteId).forward(request, response);
                return;
            }
            stmt.close();
            rs.close();
            
         // Verifica se o número de pessoas excede o máximo permitido
            String maxReservaSql = "SELECT max_reserva FROM restaurantes WHERE restaurante_id = ?";
            stmt = con.prepareStatement(maxReservaSql);
            stmt.setString(1, restauranteId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                int maxReserva = rs.getInt("max_reserva");
                if (numeroPessoas > maxReserva) {
                    request.setAttribute("erroMaxPessoas", "O número de pessoas excede o máximo permitido para uma reserva: " + maxReserva + " pessoa(s).");
                    request.getRequestDispatcher("detalhesRestaurante.jsp?id=" + restauranteId).forward(request, response);
                    return;
                }
            } else {
                request.setAttribute("erroSistema", "Restaurante não encontrado.");
                request.getRequestDispatcher("detalhesRestaurante.jsp?id=" + restauranteId).forward(request, response);
                return;
            }
            stmt.close();
            rs.close();

            // Faz o INSERT da nova reserva
            String insertSql = "INSERT INTO reservas (cliente_id, restaurante_id, data_reserva, horario_reserva, numero_pessoas, codigo_confirmacao, status, nome_reserva) "
                             + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = con.prepareStatement(insertSql);
            stmt.setInt(1, clienteId);
            stmt.setString(2, restauranteId);
            stmt.setDate(3, dataReserva);
            stmt.setTime(4, horarioReserva);
            stmt.setInt(5, numeroPessoas);
            stmt.setString(6, codigoConfirmacao);
            stmt.setString(7, status);
            stmt.setString(8, nomeReserva);

            stmt.executeUpdate();
            response.sendRedirect("visualizar_reserva.jsp");

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("erroSistema", "Erro ao salvar a reserva. Tente novamente mais tarde.");
                request.getRequestDispatcher("detalhesRestaurante.jsp?id=" + restauranteId).forward(request, response);
            }
            }
        }
    

    // Define o tipo de dia com base no dia da semana
    private String obterTipoDia(DayOfWeek dia) {
        switch (dia) {
            case SATURDAY:
            case SUNDAY:
                return "Finais de Semana";
            default:
                return "Dias da Semana";
        }
    }

    private String gerarCodigoConfirmacao() {
        Random random = new Random();
        int codigo = 10000000 + random.nextInt(90000000);
        return String.valueOf(codigo);
    }
}
