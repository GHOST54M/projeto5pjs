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
import jakarta.servlet.http.HttpSession;

@WebServlet("/loginRestaurante")
public class loginRestaurante extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cnpj = request.getParameter("cnpj");
        String senha = request.getParameter("senha");

        try (Connection conn = cnx.getConexao()) {
            String sql = "SELECT * FROM restaurantes WHERE cnpj = ? AND senha = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, cnpj);
            stmt.setString(2, senha);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int restauranteId = rs.getInt("restaurante_id"); 
                String nomeRestaurante = rs.getString("nome");

                HttpSession session = request.getSession();
                session.setAttribute("restauranteId", restauranteId);
                session.setAttribute("cnpj", cnpj); 
                session.setAttribute("nome", nomeRestaurante);

                response.sendRedirect("paginaPrincipalRestaurante.jsp");
            } else {
                response.sendRedirect("login_restaurante.jsp?erro=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login_restaurante.jsp?erro=1");
        }
    }
}
