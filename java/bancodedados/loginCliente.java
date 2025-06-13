package bancodedados;

import java.io.IOException;
import java.net.URLEncoder;
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
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        try (Connection conn = cnx.getConexao()) {
            // Verifica se o e-mail existe
            String emailQuery = "SELECT senha, cliente_id FROM clientes WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(emailQuery);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (!rs.next()) {
                // E-mail não encontrado
                response.sendRedirect("login_cliente.jsp?erro=" + 
                    URLEncoder.encode("Email incorreto ou não cadastrado", "UTF-8"));
                return;
            }

            String senhaDoBanco = rs.getString("senha");
            int userId = rs.getInt("cliente_id");

            if (!senhaDoBanco.equals(senha)) {
                // Senha incorreta
                response.sendRedirect("login_cliente.jsp?erro=" + 
                    URLEncoder.encode("Senha incorreta", "UTF-8"));
                return;
            }

            // Login bem-sucedido
            HttpSession session = request.getSession();
            session.setAttribute("userId", userId);
            response.sendRedirect("paginaPrincipalUsuario.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login_cliente.jsp?erro=" + 
                URLEncoder.encode("Erro interno no servidor", "UTF-8"));
        }
    }
}

