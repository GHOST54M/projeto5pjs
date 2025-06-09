package bancodedados;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/cancelarReserva")
public class cancelarReserva extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");

        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);

            try (Connection conn = cnx.getConexao()) {
                String sql = "DELETE FROM reservas WHERE reserva_id = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, id);
                int linhasAfetadas = stmt.executeUpdate();

                if (linhasAfetadas > 0) {
                    response.sendRedirect("visualizar_reserva.jsp");
                } else {
                    response.sendRedirect("visualizar_reserva.jsp");
                }

            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("visualizar_reserva.jsp");
            } catch (ClassNotFoundException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

        } else {
            response.sendRedirect("visualizar_reserva.jsp");
        }
    }
}
