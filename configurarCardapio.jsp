<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="bancodedados.itemMenu" %>
<!DOCTYPE html>
<html>
<head>
        <meta name="viewport" content="width=device-width, initial-scale=1">       
		<meta charset="UTF-8">
		
		<link rel="stylesheet" type="text/css" href="css/reset.css">
		<link rel="stylesheet" type="text/css" href="css/estilosRepetidos.css">
		
    <title>Configurar Cardápio</title>
    <style>
        header{
			display: flex;
			flex-direction: row-reverse;
			align-items: center;        
        }
        
		.cabecalhoimagem{
			width: 50px;
			height: 50px;
			margin-right: 20px;
		}
		
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
        }
        
	   .back-button {
	      background-color: #771b1b;
	      color: white;
	      border: none;
	      padding: 10px;
	      border-radius: 5px;
	      cursor: pointer;
	      margin-right: 30px;
	    }
	
	    .back-button:hover {
	      background-color: #5e1515;
	    }
    
        .cardapio-container {
            display: flex;
    		justify-content: center;
    		margin-top: 30px;
        }

        .itens {
            width: 700px;
           	border: 2px solid #831D1C;
			box-shadow: 2px 2px 2px 1px rgba(0, 0, 0, 0.2);
        }

        .item-card {
            display: flex;
            align-items: center;
            border: 1px solid #831D1C;
            padding: 15px;
            margin-bottom: 10px;
            background-color: #fff;
            border-radius: 5px;
            
        }

        .item-card img {
            width: 110px;
            height: 110px;
            margin-right: 15px;
        }

        .info {
            flex-grow: 1;
        }

        .info h3 {
            margin: 0;
            font-size: 18px;
        }

        .info p {
            margin: 3px 0;
            font-size: 14px;
            color: #555;
        }

        .preco {
            text-align: right;
        }

        .preco input {
            width: 50px;
        }

        .preco span {
            display: block;
            font-size: 18px;
            margin-top: 5px;
        }

        .acoes {
            margin-left: 40px;
        }

        .botao {
            display: block;
            background-color: #831D1C;
            color: white;
            border: none;
            padding: 10px 15px;
            margin-bottom: 10px;
            cursor: pointer;
            border-radius: 5px;
            width: 150px;
        }

        .acoes button:hover {
            background-color: #a40000;
        }
        
		.modal {
		    position: fixed;
		    z-index: 1;
		    left: 0;
		    top: 0;
		    width: 100%;
		    height: 100%;
		    overflow: auto;
		    background-color: rgba(0,0,0,0.5);
		}
		
		.modal-conteudo {
		    background-color: #fff;
		    margin: 10% auto;
		    padding: 20px;
		    border: 2px solid #8B0000;
		    width: 400px;
		    border-radius: 10px;
		}
		
		.fechar {
		    color: #aaa;
		    float: right;
		    font-size: 24px;
		    font-weight: bold;
		    cursor: pointer;
		}


    </style>
</head>
<body>
<header>
	<div class="cabecalho">
		<a href="perfilRestaurante.jsp"><img src="imagens/perfil.png"  class="cabecalhoimagem"></a>
		<a href=""><img src="imagens/configuracoes.png" class="cabecalhoimagem"></a>
	</div>
</header>
    <div class="cardapio-container">
    		 <a href="paginaPrincipalRestaurante.jsp"><button class="back-button">&#8592;</button></a>
    
        <div class="itens">
            <%
                Boolean menuExiste = (Boolean) request.getAttribute("menuExiste");
            if (menuExiste != null && menuExiste) {
                List<itemMenu> itens = (List<itemMenu>) request.getAttribute("itensMenu");
                String[] categorias = {"Entrada", "Prato Principal", "Sobremesa", "Bebida", "Bebida Alcóolica"};

                for (String categoria : categorias) {
                    boolean temItens = false;
                    for (itemMenu item : itens) {
                        if (item.getTipoItem().equalsIgnoreCase(categoria)) {
                            temItens = true;
                            break;
                        }
                    }

                    if (temItens) {
        %>
                        <h2 style="margin: 20px 0 10px 10px; color: #831D1C;"><%= categoria %></h2>
        <%
                        for (itemMenu item : itens) {
                            if (item.getTipoItem().equalsIgnoreCase(categoria)) {
        %>
                                <div class="item-card">
                                    <img src="<%= item.getFotoItem() %>" alt="Item"/>
                                    <div class="info">
                                        <h3><%= item.getNomeItem() %></h3>
                                        <p><%= item.getDescricaoItem() %></p>
                                    </div>
                                    <div class="preco">
                                        <label>Desconto:</label>
                                        <input type="text" name="desconto">
                                        <span>R$ <%= String.format("%.2f", item.getPrecoItem()) %></span>
                                       
                                    </div>
									<div class="acoes">
									    <button class="botao" onclick="abrirModalEditar('<%= item.getItemId() %>', '<%= item.getNomeItem() %>', '<%= item.getDescricaoItem() %>', '<%= item.getPrecoItem() %>', '<%= item.getTipoItem() %>')">Editar item</button>
										<button class="botao" onclick="abrirModalExcluir('<%= item.getItemId() %>', '<%= item.getNomeItem().replace("'", "\\'") %>')">Excluir item</button>
									</div>
                                </div>
        <%
                            }
                        }
                    }
                }
            } else {
        %>
            <p>Você ainda não possui um cardápio.</p>
            <form action="criarCardapio" method="post">
                <button type="submit">Criar Cardápio</button>
            </form>
        <%
            }
        %>
</div>

        <div class="acoes">
			<button onclick="abrirModal()" class="botao">Adicionar item</button>
        </div>
    </div>
    
<!-- Modal Adicionar Item -->
<div id="modalAdicionarItem" class="modal" style="display:none;">
  <div class="modal-conteudo">
    <span class="fechar" onclick="fecharModal()">&times;</span>
    <h3>Adicionar novo item ao cardápio</h3>
    
<form action="adicionarItemMenu" method="post" enctype="multipart/form-data">
	<%
	    Integer menuId = (Integer) session.getAttribute("menuId");
	%>
	<input type="hidden" name="menu_id" value="<%= menuId != null ? menuId : "" %>">
        
        <label for="nome">Nome do item:</label><br>
        <input type="text" name="nome_item" required><br><br>

        <label for="descricao">Descrição:</label><br>
        <textarea name="descricao_item" required></textarea><br><br>

        <label for="preco">Preço:</label><br>
        <input type="number" step="0.01" name="preco_item" required><br><br>
        
		<label for="tipo_tem">Tipo do item:</label><br>
		<select name="tipo_tem" required>
		    <option value="">-- Selecione --</option>
		    <option value="Entrada">Entrada</option>
		    <option value="Prato Principal">Prato Principal</option>
		    <option value="Sobremesa">Sobremesa</option>
		    <option value="Bebida">Bebida</option>
		    <option value="Bebida Alcóolica">Bebida Alcóolica</option>
		</select><br><br>
				
		<label for="foto">Foto do item:</label><br>
    	<input type="file" name="foto_item" accept="image/*" required><br><br>
    
        <button type="submit" class="botao">Salvar item</button>
        
    </form>
  </div>
</div>

<!-- Modal Editar Item -->

<div id="modalEditarItem" class="modal" style="display:none;">
  <div class="modal-conteudo">
    <span class="fechar" onclick="fecharModalEditar()">&times;</span>
    <h3>Editar item do cardápio</h3>

    <form action="editarItemMenu" method="post">
        <input type="hidden" name="id_item" id="edit-id">

        <label for="edit-nome">Nome:</label><br>
        <input type="text" name="nome_item" id="edit-nome" required><br><br>

        <label for="edit-descricao">Descrição:</label><br>
        <textarea name="descricao_item" id="edit-descricao" required></textarea><br><br>

        <label for="edit-preco">Preço:</label><br>
        <input type="number" step="0.01" name="preco_item" id="edit-preco" required><br><br>

        <label for="edit-tipo">Tipo do item:</label><br>
        <select name="tipo_tem" id="edit-tipo" required>
            <option value="Entrada">Entrada</option>
            <option value="Prato Principal">Prato Principal</option>
            <option value="Sobremesa">Sobremesa</option>
            <option value="Bebida">Bebida</option>
            <option value="Bebida Alcóolica">Bebida Alcóolica</option>
        </select><br><br>

        <button type="submit" class="botao">Salvar alterações</button>
    </form>
  </div>
</div>

<!-- Modal Excluir Item -->

<div id="modalExcluirItem" class="modal" style="display:none;">
  <div class="modal-conteudo">
    <span class="fechar" onclick="fecharModalExcluir()">&times;</span>
    <h3>Confirmar exclusão</h3>
	<p>Tem certeza que deseja excluir o item <strong id="nomeItemExcluir"></strong> do cardápio?</p>
    <form action="excluirItemMenu" method="post">
        <input type="hidden" name="id_item" id="excluir-id">
        <button type="submit" class="botao">Sim, excluir</button>
        <button type="button" class="botao" onclick="fecharModalExcluir()">Cancelar</button>
    </form>
  </div>
</div>

<script>
	function abrirModal() {
	    document.getElementById("modalAdicionarItem").style.display = "block";
	}
	
	function fecharModal() {
	    document.getElementById("modalAdicionarItem").style.display = "none";
	}
	function abrirModalEditar(id, nome, descricao, preco, tipo) {
	    document.getElementById("edit-id").value = id;
	    document.getElementById("edit-nome").value = nome;
	    document.getElementById("edit-descricao").value = descricao;
	    document.getElementById("edit-preco").value = preco;
	    document.getElementById("edit-tipo").value = tipo;
	    document.getElementById("modalEditarItem").style.display = "block";
	}

	function fecharModalEditar() {
	    document.getElementById("modalEditarItem").style.display = "none";
	}

	function abrirModalExcluir(id, nome) {
	    document.getElementById("excluir-id").value = id;
	    document.getElementById("nomeItemExcluir").textContent = nome;
	    document.getElementById("modalExcluirItem").style.display = "block";
	}


	function fecharModalExcluir() {
	    document.getElementById("modalExcluirItem").style.display = "none";
	}
</script>

</body>
</html>
