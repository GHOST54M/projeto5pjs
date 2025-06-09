package bancodedados;

public class restaurante {
    private int restauranteId;
    private String nome;
    private int capacidadeMaxima;
	private int lotacao;
    private int maxReserva;
    private String especialidadeGastronomica;
    private String email;
    private String cnpj;
    private String municipio;
    private String uf;
    private String rua;
    private int numero;
    private int cep;
    private String descricao;
    private String telefone1;
    private String telefone2;
    private String fotoPerfil;

    // Construtor
    public restaurante(int restauranteId, String nome, int capacidadeMaxima,int lotacao, int maxReserva, String especialidadeGastronomica,
                       String email, String cnpj, String municipio, String uf, String rua, int numero, int cep,
                       String descricao, String telefone1, String telefone2, String fotoPerfil) {
        this.restauranteId = restauranteId;
        this.nome = nome;
        this.capacidadeMaxima = capacidadeMaxima;
        this.lotacao = lotacao;
        this.maxReserva = maxReserva;
        this.especialidadeGastronomica = especialidadeGastronomica;
        this.email = email;
        this.cnpj = cnpj;
        this.municipio = municipio;
        this.uf = uf;
        this.rua = rua;
        this.numero = numero;
        this.cep = cep;
        this.descricao = descricao;
        this.telefone1 = telefone1;
        this.telefone2 = telefone2;
        this.fotoPerfil = fotoPerfil;
    }


    public int getRestauranteId() {
        return restauranteId;
    }

    public void setRestauranteId(int restauranteId) {
        this.restauranteId = restauranteId;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public int getCapacidadeMaxima() {
        return capacidadeMaxima;
    }

    public void setCapacidadeMaxima(int capacidadeMaxima) {
        this.capacidadeMaxima = capacidadeMaxima;
    }
    
    public int getLotacao() {
		return lotacao;
	}


	public void setLotacao(int lotacao) {
		this.lotacao = lotacao;
	}

    public int getMaxReserva() {
        return maxReserva;
    }

    public void setMaxReserva(int maxReserva) {
        this.maxReserva = maxReserva;
    }

    public String getEspecialidadeGastronomica() {
        return especialidadeGastronomica;
    }

    public void setEspecialidadeGastronomica(String especialidadeGastronomica) {
        this.especialidadeGastronomica = especialidadeGastronomica;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCnpj() {
        return cnpj;
    }

    public void setCnpj(String cnpj) {
        this.cnpj = cnpj;
    }

    public String getMunicipio() {
        return municipio;
    }

    public void setMunicipio(String municipio) {
        this.municipio = municipio;
    }

    public String getUf() {
        return uf;
    }

    public void setUf(String uf) {
        this.uf = uf;
    }

    public String getRua() {
        return rua;
    }

    public void setRua(String rua) {
        this.rua = rua;
    }

    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }

    public int getCep() {
        return cep;
    }

    public void setCep(int cep) {
        this.cep = cep;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getTelefone1() {
        return telefone1;
    }

    public void setTelefone1(String telefone1) {
        this.telefone1 = telefone1;
    }

    public String getTelefone2() {
        return telefone2;
    }

    public void setTelefone2(String telefone2) {
        this.telefone2 = telefone2;
    }

    public String getFotoPerfil() {
        return fotoPerfil;
    }

    public void setFotoPerfil(String fotoPerfil) {
        this.fotoPerfil = fotoPerfil;
    }

}

