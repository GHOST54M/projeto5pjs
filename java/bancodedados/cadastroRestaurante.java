package bancodedados;

import java.io.*;
import java.sql.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/cadastroRestaurante")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,  // 1MB
    maxFileSize = 1024 * 1024 * 5,    // 5MB
    maxRequestSize = 1024 * 1024 * 10 // 10MB
)
public class cadastroRestaurante extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recupera os dados da sessão
        HttpSession session = request.getSession();
        String nome = (String) session.getAttribute("nome");
        String email = (String) session.getAttribute("email");
        String cnpj = (String) session.getAttribute("cnpj");
        String municipio = (String) session.getAttribute("municipio");
        String uf = (String) session.getAttribute("uf");
        String rua = (String) session.getAttribute("rua");
        String numero = (String) session.getAttribute("numero");
        String cep = (String) session.getAttribute("cep");
        String senha = (String) session.getAttribute("senha");
        // Recupera dados do formulário
        String telefone1 = request.getParameter("telefone1");
        String telefone2 = request.getParameter("telefone2");
        String[] especialidades = request.getParameterValues("especialidades");
        String descricao = request.getParameter("descricao");

        String semanaAbre = request.getParameter("semana_abre");
        String semanaFecha = request.getParameter("semana_fecha");
        String feriadoAbre = request.getParameter("feriado_abre");
        String feriadoFecha = request.getParameter("feriado_fecha");
        String fdsAbre = request.getParameter("fds_abre");
        String fdsFecha = request.getParameter("fds_fecha");

        int capacidade = Integer.parseInt(request.getParameter("capacidade"));
        int maxReserva = Integer.parseInt(request.getParameter("max_reserva"));
        int lotacao = 0;

        // Processa o upload da imagem
        Part filePart = request.getPart("foto");
        String nomeArquivo = filePart.getSubmittedFileName();

        String caminhoUpload = getServletContext().getRealPath("/") + "uploads";
        File uploadDir = new File(caminhoUpload);
        if (!uploadDir.exists()) uploadDir.mkdir();
        String caminhoCompleto = caminhoUpload + File.separator + nomeArquivo;
        filePart.write(caminhoCompleto);
        String caminhoFoto = "uploads/" + nomeArquivo;

        Connection conn = null;
        PreparedStatement stmtRest = null;
        PreparedStatement stmtHorario = null;

        try {
            conn = cnx.getConexao();

            String sqlRest = "INSERT INTO restaurantes (nome, cnpj, telefone1, telefone2, capacidade_maxima,lotacao, max_reserva, especialidade_gastronomica, email, senha, municipio, uf,rua, numero, cep, descricao, foto_perfil) VALUES (?, ?, ?, ?,?,?, ?, ?,?, ?, ?, ?, ?, ?, ?, ?, ?)";
            stmtRest = conn.prepareStatement(sqlRest, Statement.RETURN_GENERATED_KEYS);
            stmtRest.setString(1, nome);
            stmtRest.setString(2, cnpj);
            stmtRest.setString(3, telefone1);
            stmtRest.setString(4, telefone2);
            stmtRest.setInt(5, capacidade);
            stmtRest.setInt(6, lotacao);
            stmtRest.setInt(7, maxReserva);
            stmtRest.setString(8, String.join(", ", especialidades));
            stmtRest.setString(9, email);
            stmtRest.setString(10, senha);
            stmtRest.setString(11, municipio);
            stmtRest.setString(12, uf);
            stmtRest.setString(13, rua);
            stmtRest.setString(14, numero);
            stmtRest.setString(15, cep);
            stmtRest.setString(16, descricao);
            stmtRest.setString(17, caminhoFoto);
            stmtRest.executeUpdate();

            ResultSet rs = stmtRest.getGeneratedKeys();
            int restauranteId = 0;
            if (rs.next()) {
                restauranteId = rs.getInt(1);
            }

            String sqlHorario = "INSERT INTO horarios_funcionamento (restaurante_id, dia_semana, hora_abertura, hora_fechamento) VALUES (?, ?, ?, ?)";
            stmtHorario = conn.prepareStatement(sqlHorario);

            stmtHorario.setInt(1, restauranteId);
            stmtHorario.setString(2, "Dias da Semana");
            stmtHorario.setString(3, semanaAbre);
            stmtHorario.setString(4, semanaFecha);
            stmtHorario.executeUpdate();

            stmtHorario.setInt(1, restauranteId);
            stmtHorario.setString(2, "Feriados");
            stmtHorario.setString(3, feriadoAbre);
            stmtHorario.setString(4, feriadoFecha);
            stmtHorario.executeUpdate();

            stmtHorario.setInt(1, restauranteId);
            stmtHorario.setString(2, "Finais de Semana");
            stmtHorario.setString(3, fdsAbre);
            stmtHorario.setString(4, fdsFecha);
            stmtHorario.executeUpdate();

            response.sendRedirect("login_restaurante.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("erroCadastro.jsp");
        } finally {
            try { if (stmtRest != null) stmtRest.close(); } catch (Exception e) {}
            try { if (stmtHorario != null) stmtHorario.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
