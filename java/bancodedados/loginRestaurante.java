package bancodedados;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.RequestDispatcher;
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
            // Verifica se o CNPJ existe
            String sqlCnpj = "SELECT * FROM restaurantes WHERE cnpj = ?";
            PreparedStatement stmtCnpj = conn.prepareStatement(sqlCnpj);
            stmtCnpj.setString(1, cnpj);
            ResultSet rsCnpj = stmtCnpj.executeQuery();

            if (!rsCnpj.next()) {
                // CNPJ não encontrado
                request.setAttribute("mensagemErro", "CNPJ não cadastrado ou inválido.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("login_restaurante.jsp");
                dispatcher.forward(request, response);
                return;
            }

            // CNPJ existe, agora verifica a senha
            String senhaCorreta = rsCnpj.getString("senha");

            if (!senha.equals(senhaCorreta)) {
                request.setAttribute("mensagemErro", "Senha incorreta.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("login_restaurante.jsp");
                dispatcher.forward(request, response);
                return;
            }

            // Login correto
            int restauranteId = rsCnpj.getInt("restaurante_id");
            String nomeRestaurante = rsCnpj.getString("nome");

            HttpSession session = request.getSession();
            session.setAttribute("restauranteId", restauranteId);
            session.setAttribute("cnpj", cnpj);
            session.setAttribute("nome", nomeRestaurante);

            response.sendRedirect("paginaPrincipalRestaurante.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login_restaurante.jsp?erro=1");
        }
    }
}
