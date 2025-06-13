package bancodedados;

import java.sql.*;
import java.util.*;

public class exibirCardapio {

	public List<itemMenu> buscarItensPorRestauranteId(int restauranteId) {
        List<itemMenu> itens = new ArrayList<>();
        String sql = "SELECT im.* FROM itens_menu im " +
                     "JOIN menus m ON im.menu_id = m.menu_id " +
                     "WHERE m.restaurante_id = ?";

        try (Connection con = cnx.getConexao();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, restauranteId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int itemId = rs.getInt("item_id");
                String nomeItem = rs.getString("nome_item");
                String descricaoItem = rs.getString("descricao_item");
                double precoItem = rs.getDouble("preco_item");
                String fotoItem = rs.getString("foto_item");
                String tipoItem = rs.getString("tipo_item");

                itemMenu item = new itemMenu(itemId, nomeItem, descricaoItem, precoItem, fotoItem, tipoItem);
                itens.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace(); // Em produção, você pode usar um logger
        }

        return itens;
    }
}
