package bancodedados;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")

public class logout extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Invalida a sessão atual
        HttpSession session = request.getSession(false); // false evita criar nova sessão
        if (session != null) {
            session.invalidate();
        }

        // Redireciona para a página de login ou inicial
        response.sendRedirect("index.jsp");
    }
}
