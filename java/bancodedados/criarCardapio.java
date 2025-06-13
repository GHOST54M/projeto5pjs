package bancodedados;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



@WebServlet("/criarCardapio")
public class criarCardapio extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("restauranteId") == null) {
            response.sendRedirect("loginRestaurante.jsp");
            return;
        }

        int restauranteId = (int) session.getAttribute("restauranteId");

        try (Connection con = cnx.getConexao()) {
            // Cria um novo menu associado ao restaurante
            String sql = "INSERT INTO menus (restaurante_id) VALUES (?)";
            try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, restauranteId);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("erro.jsp");
            return;
        }

        // Redireciona para o servlet que exibe o menu
        response.sendRedirect("verificarMenu");
    }
}

