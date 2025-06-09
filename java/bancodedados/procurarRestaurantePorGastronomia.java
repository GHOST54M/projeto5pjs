package bancodedados;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

@WebServlet("/procurarRestaurantePorGastronomia")

public class procurarRestaurantePorGastronomia extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String especialidade = request.getParameter("especialidade");

        ArrayList<restaurante> lista = new ArrayList<>();

        try (Connection conn = cnx.getConexao()) {
            String sql = "SELECT * FROM restaurantes WHERE especialidade_gastronomica = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, especialidade);
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

            request.setAttribute("restaurantes", lista);
            request.setAttribute("especialidadeSelecionada", especialidade);
            RequestDispatcher dispatcher = request.getRequestDispatcher("paginaRestaurantes.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("erro.jsp");
        }
    }

}
