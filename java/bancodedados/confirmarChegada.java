package bancodedados;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/confirmarChegada")
public class confirmarChegada extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String reservaId = request.getParameter("reservaId");
        String codigoInformado = request.getParameter("codigo");
        System.out.println("reservaId recebido: '" + reservaId + "'");
        System.out.println("codigo recebido: '" + codigoInformado + "'");

        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        boolean codigoValido = verificarCodigoConfirmacao(reservaId, codigoInformado);

        if (codigoValido) {
            marcarReservaComoConfirmada(reservaId);
            out.print("{\"success\": true}");
        } else {
            out.print("{\"success\": false, \"message\": \"Código incorreto. Tente novamente.\"}");
        }

        out.flush();
    }

    private boolean verificarCodigoConfirmacao(String reservaId, String codigoInformado) {
        String sql = "SELECT codigo_confirmacao FROM reservas WHERE reserva_id = ?";
        try (Connection con = cnx.getConexao();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, Integer.parseInt(reservaId));
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String codigoBanco = rs.getString("codigo_confirmacao");
                    return codigoBanco != null && codigoBanco.equals(codigoInformado);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    private void marcarReservaComoConfirmada(String reservaId) {
        String sql = "UPDATE reservas SET status = 'confirmada' WHERE reserva_id = ?";
        try (Connection con = cnx.getConexao();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, Integer.parseInt(reservaId));
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

