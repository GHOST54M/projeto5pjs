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

@WebServlet("/loginCliente")

public class loginCliente extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        try (Connection conn = cnx.getConexao()) {
            String query = "SELECT * FROM clientes WHERE email = ? AND senha = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            stmt.setString(2, senha);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int userId = rs.getInt("cliente_id"); // Obter o ID do usuário
                System.out.print(userId);
                // Criar uma sessão e armazenar o ID do usuário
                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);

                response.sendRedirect("paginaPrincipalUsuario.jsp");
            } else {
                response.sendRedirect("login_cliente.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login_cliente.jsp?error=1");
        }
    }
}
