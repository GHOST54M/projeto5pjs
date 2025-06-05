package bancodedados;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class cnx {
    // Dados de conexão
    private static final String URL = "jdbc:mysql://localhost:3306/5pjs";
    private static final String USUARIO = "root";
    private static final String SENHA = "";

    public static Connection getConexao() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USUARIO, SENHA);
    }

}
