package bancodedados;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

@WebServlet("/buscarRestaurantePorNome")

public class procurarRestaurantePorNome extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nomeBusca = request.getParameter("pesquisa");
        ArrayList<restaurante> lista = new ArrayList<>();

        try (Connection con = cnx.getConexao()) {
            String sql = "SELECT * FROM restaurantes WHERE nome LIKE ?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, "%" + nomeBusca + "%");

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                restaurante r = new restaurante(
                        rs.getInt("restaurante_Id"),
                        rs.getString("nome"),
                        rs.getInt("capacidade_maxima"),
                        rs.getInt("lotacao"),
                        rs.getInt("max_reserva"),
                        rs.getString("especialidade_gastronomica"),
                        rs.getString("email"),
                        rs.getString("cnpj"),
                        rs.getString("municipio"),
                        rs.getString("uf"),
                        rs.getString("rua"),
                        rs.getInt("numero"),
                        rs.getInt("cep"),
                        rs.getString("descricao"),
                        rs.getString("telefone1"),
                        rs.getString("telefone2"),
                        rs.getString("foto_perfil")
                );
                lista.add(r);
            }

            rs.close();
            stmt.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("restaurantesEncontrados", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("resultadosBusca.jsp");
        dispatcher.forward(request, response);
    }
}

