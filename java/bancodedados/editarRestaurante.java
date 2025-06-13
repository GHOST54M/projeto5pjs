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

@WebServlet("/editarRestaurante")
public class editarRestaurante extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");

        int restauranteId = Integer.parseInt(request.getParameter("id"));
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String cnpj = request.getParameter("cnpj");
        String telefone1 = request.getParameter("telefone1");
        String telefone2 = request.getParameter("telefone2");
        String descricao = request.getParameter("descricao");
        String capacidade = request.getParameter("capacidade");
        String maxReserva = request.getParameter("maxReserva");
        String uf = request.getParameter("uf");
        String municipio = request.getParameter("municipio");
        String rua = request.getParameter("Rua");
        String cep = request.getParameter("CEP");
        
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = cnx.getConexao();

            String sql = "UPDATE restaurantes SET nome = ?, capacidade_maxima = ?, max_reserva= ?, email = ?, cnpj = ?, municipio = ?, uf = ?, rua = ?, cep = ?, telefone1 = ?, telefone2 = ?, descricao = ? WHERE restaurante_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, nome);
            stmt.setString(2, capacidade);
            stmt.setString(3, maxReserva);
            stmt.setString(4, email);
            stmt.setString(5, cnpj);
            stmt.setString(6, municipio);
            stmt.setString(7, uf);
            stmt.setString(8, rua);
            stmt.setString(9, cep);
            stmt.setString(10, telefone1);
            stmt.setString(11, telefone2);
            stmt.setString(12, descricao);
            stmt.setInt(13, restauranteId);

            stmt.executeUpdate();

            response.sendRedirect("perfilRestaurante.jsp?sucesso=1");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("perfilRestaurante.jsp?erro=Erro+ao+editar+dados");
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

