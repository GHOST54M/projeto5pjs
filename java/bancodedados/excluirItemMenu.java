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

@WebServlet("/excluirItemMenu")
public class excluirItemMenu extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        int idItem = Integer.parseInt(request.getParameter("id_item"));

        Connection con = null;
        PreparedStatement stmt = null;

        try {
            con = cnx.getConexao();

            String sql = "DELETE FROM itens_menu WHERE item_id = ?";
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, idItem);
            stmt.executeUpdate();

            response.sendRedirect("paginaPrincipalRestaurante.jsp");

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("erro.jsp");  // Opcional: página para tratar erros
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
