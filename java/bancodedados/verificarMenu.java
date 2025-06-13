package bancodedados;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/verificarMenu")
public class verificarMenu extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("restauranteId") == null) {
            response.sendRedirect("loginRestaurante.jsp");
            return;
        }

        int restauranteId = (int) session.getAttribute("restauranteId");
        boolean menuExiste = false;
        int menuId = -1;
        List<itemMenu> itens = new ArrayList<>();

        try (Connection con = cnx.getConexao()) {
            // 1. Verifica se o menu existe e recupera o menu_id
            String sqlMenu = "SELECT menu_id FROM menus WHERE restaurante_id = ?";
            try (PreparedStatement ps = con.prepareStatement(sqlMenu)) {
                ps.setInt(1, restauranteId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        menuExiste = true;
                        menuId = rs.getInt("menu_id");
                        session.setAttribute("menuId", menuId);

                    }
                }
            }

            // 2. Se existir um menu, recupera os itens do menu
            if (menuExiste) {
                String sqlItens = "SELECT item_id, nome_item, descricao_item, preco_item, foto_item, tipo_item FROM itens_menu WHERE menu_id = ?";
                try (PreparedStatement ps = con.prepareStatement(sqlItens)) {
                    ps.setInt(1, menuId);
                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                        	itemMenu item = new itemMenu(
                                rs.getInt("item_id"),
                                rs.getString("nome_item"),
                                rs.getString("descricao_item"),
                                rs.getDouble("preco_item"),
                                rs.getString("foto_item"),
                                rs.getString("tipo_item")

                            );
                            itens.add(item);
                        }
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("erro.jsp");
            return;
        }

        request.setAttribute("menuExiste", menuExiste);
        request.setAttribute("itensMenu", itens);
        request.getRequestDispatcher("configurarCardapio.jsp").forward(request, response);
    }

}