package bancodedados;

public class reserva {
	private int reservaId;
    private int clienteId;
    private int restauranteId;
    private java.sql.Date dataReserva;
    private java.sql.Time horarioReserva;
    private int numeroPessoas;
    private String codigoConfirmacao;
    private String status;
    private String nomeReserva;
	private String nomeRestaurante;
    private String ruaRestaurante;
    private String numeroRestaurante;
    private String cepRestaurante;
    
    public int getReservaId() {
		return reservaId;
	}
	public void setReservaId(int reservaId) {
		this.reservaId = reservaId;
	}
	public int getClienteId() {
		return clienteId;
	}
	public void setClienteId(int clienteId) {
		this.clienteId = clienteId;
	}
	public int getRestauranteId() {
		return restauranteId;
	}
	public void setRestauranteId(int restauranteId) {
		this.restauranteId = restauranteId;
	}
	public java.sql.Date getDataReserva() {
		return dataReserva;
	}
	public void setDataReserva(java.sql.Date dataReserva) {
		this.dataReserva = dataReserva;
	}
	public java.sql.Time getHorarioReserva() {
		return horarioReserva;
	}
	public void setHorarioReserva(java.sql.Time horarioReserva) {
		this.horarioReserva = horarioReserva;
	}
	public int getNumeroPessoas() {
		return numeroPessoas;
	}
	public void setNumeroPessoas(int numeroPessoas) {
		this.numeroPessoas = numeroPessoas;
	}
	public String getCodigoConfirmacao() {
		return codigoConfirmacao;
	}
	public void setCodigoConfirmacao(String codigoConfirmacao) {
		this.codigoConfirmacao = codigoConfirmacao;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getNomeReserva() {
		return nomeReserva;
	}
	public void setNomeReserva(String nomeReserva) {
		this.nomeReserva = nomeReserva;
	}
    public String getNomeRestaurante() {
		return nomeRestaurante;
	}
	public void setNomeRestaurante(String nomeRestaurante) {
		this.nomeRestaurante = nomeRestaurante;
	}
	public String getRuaRestaurante() {
		return ruaRestaurante;
	}
	public void setRuaRestaurante(String ruaRestaurante) {
		this.ruaRestaurante = ruaRestaurante;
	}
	public String getNumeroRestaurante() {
		return numeroRestaurante;
	}
	public void setNumeroRestaurante(String numeroRestaurante) {
		this.numeroRestaurante = numeroRestaurante;
	}
	public String getCepRestaurante() {
		return cepRestaurante;
	}
	public void setCepRestaurante(String cepRestaurante) {
		this.cepRestaurante = cepRestaurante;
	}
}
