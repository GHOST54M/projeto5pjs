package bancodedados;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
        String rua = request.getParameter("rua");
        String cep = request.getParameter("cep");

        String verificaEmailSQL = "SELECT COUNT(*) FROM Clientes WHERE email = ?";
        String inserirClienteSQL = "INSERT INTO Clientes (nome, telefone, email, senha, rua, cep) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = cnx.getConexao()) {

            // Verifica se o e-mail já existe
            try (PreparedStatement stmtVerifica = conn.prepareStatement(verificaEmailSQL)) {
                stmtVerifica.setString(1, email);
                ResultSet rs = stmtVerifica.executeQuery();

                if (rs.next() && rs.getInt(1) > 0) {
                	response.sendRedirect("cadastroCliente.jsp?erro=" + URLEncoder.encode("Email já está cadastrado", "UTF-8"));
                    return; // Encerra a execução
                }
            }

            // Insere o novo cliente
            try (PreparedStatement stmtInserir = conn.prepareStatement(inserirClienteSQL)) {
                stmtInserir.setString(1, nome);
                stmtInserir.setString(2, telefone);
                stmtInserir.setString(3, email);
                stmtInserir.setString(4, senha);
                stmtInserir.setString(5, rua);
                stmtInserir.setString(6, cep);

                stmtInserir.executeUpdate();
            }

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

