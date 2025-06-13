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

@WebServlet("/editarCliente")
public class editarCliente extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        int clienteId = Integer.parseInt(request.getParameter("id"));
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String telefone = request.getParameter("telefone");
        String rua = request.getParameter("Rua");
        String cep = request.getParameter("CEP");
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = cnx.getConexao(); // Uso da sua classe cnx

            String sql = "UPDATE clientes SET nome = ?, email = ?, telefone = ?, rua = ?, cep = ? WHERE cliente_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, nome);
            stmt.setString(2, email);
            stmt.setString(3, telefone);
            stmt.setString(4, rua);
            stmt.setString(5, cep);
            stmt.setInt(6, clienteId);

            stmt.executeUpdate();

            response.sendRedirect("perfilUsuario.jsp?sucesso=1");

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("perfilUsuario.jsp?erro=Erro+ao+editar+cliente");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}

