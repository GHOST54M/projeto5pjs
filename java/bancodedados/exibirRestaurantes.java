package bancodedados;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class exibirRestaurantes {

	 private static final String SELECT_ALL = "SELECT * FROM restaurantes";

	    public List<restaurante> listarRestaurantes() {
	        List<restaurante> lista = new ArrayList<>();

	        try (Connection conn = cnx.getConexao();
	             PreparedStatement stmt = conn.prepareStatement(SELECT_ALL);
	             ResultSet rs = stmt.executeQuery()) {

	            while (rs.next()) {
	            	restaurante r = new restaurante(
	                    rs.getInt("restaurante_id"),
	                    rs.getString("nome"),
	                    rs.getInt("capacidade_maxima"),
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

	        }catch (ClassNotFoundException e) {
	            e.printStackTrace(); // ou outro tratamento
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return lista;
	    }
	    
	    public restaurante buscarRestaurantePorId(int id) {
	        restaurante r = null;
	        Connection conn = null;
	        PreparedStatement stmt = null;
	        ResultSet rs = null;

	        try {
	            conn = cnx.getConexao(); // Usa sua classe de conexão
	            String sql = "SELECT * FROM restaurantes WHERE restaurante_id = ?";
	            stmt = conn.prepareStatement(sql);
	            stmt.setInt(1, id);
	            rs = stmt.executeQuery();

	            if (rs.next()) {
	                r = new restaurante(
	                    rs.getInt("restaurante_id"),
	                    rs.getString("nome"),
	                    rs.getInt("capacidade_maxima"),
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
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            try { if (rs != null) rs.close(); } catch (Exception e) { }
	            try { if (stmt != null) stmt.close(); } catch (Exception e) { }
	            try { if (conn != null) conn.close(); } catch (Exception e) { }
	        }

	        return r;
	    }
}