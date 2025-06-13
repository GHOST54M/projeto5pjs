package bancodedados;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;


@WebServlet("/adicionarItemMenu")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 15)   // 15MB
public class adicionarItemMenu extends HttpServlet {
	
    private static final long serialVersionUID = 1L;

    private static final String UPLOAD_DIR = "imagens_itens";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int menuId = Integer.parseInt(request.getParameter("menu_id"));
        String nome = request.getParameter("nome_item");
        String descricao = request.getParameter("descricao_item");
        double preco = Double.parseDouble(request.getParameter("preco_item"));
        String tipo = request.getParameter("tipo_tem");

        // Foto
        Part filePart = request.getPart("foto_item");
        String fileName = UUID.randomUUID().toString() + "_" + filePart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        File file = new File(uploadPath + File.separator + fileName);
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, file.toPath());
        }

        try (Connection con = cnx.getConexao()) {
        	String sql = "INSERT INTO itens_menu (menu_id, nome_item, descricao_item, preco_item, foto_item, tipo_item) VALUES (?, ?, ?, ?, ?, ?)";
        	try (PreparedStatement ps = con.prepareStatement(sql)) {
        	    ps.setInt(1, menuId);
        	    ps.setString(2, nome);
        	    ps.setString(3, descricao);
        	    ps.setDouble(4, preco);
        	    ps.setString(5, UPLOAD_DIR + "/" + fileName);
        	    ps.setString(6, tipo);
        	    ps.executeUpdate();
        	}

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("erro.jsp");
            return;
        }

        response.sendRedirect("verificarMenu");
    }
}

