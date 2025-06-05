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

@WebServlet("/cadastroCliente")

public class cadastroCliente extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nome = request.getParameter("nome");
        String telefone = request.getParameter("telefone");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        String sql = "INSERT INTO Clientes (nome, telefone, email, senha) VALUES (?, ?, ?, ?)";

        try (Connection conn = cnx.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, nome);
            stmt.setString(2, telefone);
            stmt.setString(3, email);
            stmt.setString(4, senha);

            stmt.executeUpdate();

            response.sendRedirect("login_cliente.jsp");

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("cadastroCliente.jsp?erro=Erro+ao+carregar+driver+JDBC");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("cadastroCliente.jsp?erro=Erro+de+conexão+ou+inserção+no+Banco+de+Dados");
        }
    }
}
