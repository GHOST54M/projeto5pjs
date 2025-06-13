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

@WebServlet("/editarItemMenu")
public class editarItemMenu extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Recebe os parâmetros do formulário
        int idItem = Integer.parseInt(request.getParameter("id_item"));
        String nome = request.getParameter("nome_item");
        String descricao = request.getParameter("descricao_item");
        double preco = Double.parseDouble(request.getParameter("preco_item"));
        String tipo = request.getParameter("tipo_tem");

        Connection con = null;
        PreparedStatement stmt = null;

        try {
            con = cnx.getConexao();
            String sql = "UPDATE itens_menu SET nome_item = ?, descricao_item = ?, preco_item = ?, tipo_item = ? WHERE item_id = ?";
            stmt = con.prepareStatement(sql);

            stmt.setString(1, nome);
            stmt.setString(2, descricao);
            stmt.setDouble(3, preco);
            stmt.setString(4, tipo);
            stmt.setInt(5, idItem);

            stmt.executeUpdate();

            response.sendRedirect("paginaPrincipalRestaurante.jsp");

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("erro.jsp");  // Crie uma página de erro se quiser
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}

