package bancodedados;

public class itemMenu {


	private int itemId;
    private String nomeItem;
    private String descricaoItem;
    private double precoItem;
	private String fotoItem;
	private String tipoItem;

	public itemMenu(int itemId, String nomeItem, String descricaoItem, double precoItem,String fotoItem,String tipoItem) {
        this.itemId = itemId;
        this.nomeItem = nomeItem;
        this.descricaoItem = descricaoItem;
        this.precoItem = precoItem;
        this.fotoItem = fotoItem;
        this.tipoItem = tipoItem;      
    }
	public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public String getNomeItem() {
		return nomeItem;
	}

	public void setNomeItem(String nomeItem) {
		this.nomeItem = nomeItem;
	}

	public String getDescricaoItem() {
		return descricaoItem;
	}

	public void setDescricaoItem(String descricaoItem) {
		this.descricaoItem = descricaoItem;
	}

	public double getPrecoItem() {
		return precoItem;
	}

	public void setPrecoItem(double precoItem) {
		this.precoItem = precoItem;
	}

	public String getFotoItem() {
		return fotoItem;
	}

	public void setFotoItem(String fotoItem) {
		this.fotoItem = fotoItem;
	}

	public String getTipoItem() {
		return tipoItem;
	}

	public void setTipoItem(String tipoItem) {
		this.tipoItem = tipoItem;
	}
}

