package bancodedados;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.Locale;

public class buscarHorarios {

    public static class HorarioFuncionamento {
        private String horaAbertura;
        private String horaFechamento;

        public HorarioFuncionamento(String horaAbertura, String horaFechamento) {
            this.horaAbertura = horaAbertura;
            this.horaFechamento = horaFechamento;
        }

        public String getHoraAbertura() {
            return horaAbertura;
        }

        public String getHoraFechamento() {
            return horaFechamento;
        }
    }

    public HorarioFuncionamento buscarHorarioDoDia(String restauranteId) {
        HorarioFuncionamento horario = null;

        try {
            // Determina se hoje é um dia da semana, final de semana ou feriado (excluído por simplicidade)
            DayOfWeek hoje = LocalDate.now().getDayOfWeek();
            String tipoDia;

            switch (hoje) {
                case SATURDAY:
                case SUNDAY:
                    tipoDia = "Finais de Semana";
                    break;
                default:
                    tipoDia = "Dias da Semana";
                    break;
            }

            // OBS: Para tratar feriados, seria necessário uma tabela separada com datas específicas
            // Aqui estamos tratando apenas dia útil e fim de semana.

            Connection con = cnx.getConexao(); // Supondo que cnx retorna conexão válida
            String sql = "SELECT hora_abertura, hora_fechamento FROM horarios_funcionamento "
                       + "WHERE restaurante_id = ? AND dia_semana = ?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, restauranteId);
            stmt.setString(2, tipoDia);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String horaAbertura = rs.getString("hora_abertura");
                String horaFechamento = rs.getString("hora_fechamento");
                horario = new HorarioFuncionamento(horaAbertura, horaFechamento);
            }

            rs.close();
            stmt.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return horario;
    }

}