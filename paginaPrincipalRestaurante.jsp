<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="bancodedados.buscarReservaPoraRestaurante" %>
<%@ page import="bancodedados.reserva" %>
<%@ page import="bancodedados.restaurante" %>
<%@ page import="bancodedados.buscarLotacao" %>
<%@ page import="java.sql.SQLException" %>

<%
	Integer restauranteId = (Integer) session.getAttribute("restauranteId");
    buscarReservaPoraRestaurante buscador = new buscarReservaPoraRestaurante();
    List<reserva> reservas = null;

    try {
        reservas = buscador.listarReservasPorRestaurante(restauranteId);
    } catch (SQLException e) {
        out.println("<p>Erro ao buscar reservas: " + e.getMessage() + "</p>");
    }
%>
<!DOCTYPE html>
<html>
<head>
        <meta name="viewport" content="width=device-width, initial-scale=1">       
		<meta charset="UTF-8">
		
		<link rel="stylesheet" type="text/css" href="css/reset.css">
		<link rel="stylesheet" type="text/css" href="css/estilosRepetidos.css">
		
    <title>Painel do Restaurante</title>


		<style>
		body{
       		font-family: Arial, sans-serif; 	
    
    	}
		header {
			position: relative;
			display: flex;
			justify-content: center; /* centraliza o conteúdo horizontalmente */
			align-items: center;
			height: 100px; /* ajuste conforme necessário */
			border-bottom: 1px solid #ccc;
		}
		
		header h1 {
			margin: 0;
			position: absolute;
			left: 50%;
			transform: translateX(-50%);
			color: #FFFFFF;
			font-size: 30px;
		}
		
		.cabecalho {
			position: absolute;
			right: 20px;
			display: flex;
			gap: 10px;
		}
		
		.cabecalhoimagem {
			width: 52px; /* ajuste o tamanho conforme necessário */
			height: 52px;
		}

		.container1{
			display: flex;
			align-items: center;
    		justify-content: space-evenly;
		
		}
		.container{
		    display: flex;
    		justify-content: space-evenly;
		}
		.lotacao{
		    text-align: center;
			font-size:30px;
		}
		.reservas_pendentes, .reservas_ativas{
		width: 500px;
		margin-top:30px;
		padding: 15px;
		border: 2px solid #831D1C;
		box-shadow: 2px 2px 2px 1px rgba(0, 0, 0, 0.2);		
		}
		
		.reserva_pendente{
		margin-top:20px;
		border-top: 1px solid grey;
		border-bottom: 1px solid grey;
		display:flex;
		align-items: center;
		justify-content: space-between;
		}
		
		p{
		padding:10px;
		}
		
		h1{
		font-size:24px;
		text-align: center;		
		}
		
		.botao-aceitar{
		text-decoration:none;
		background-color: #831D1C;
		color: white;
		border: none;
		padding: 7px 12px;
		font-size: 18px;
		cursor: pointer;
		}
		.modal {
		    position: fixed;
		    top: 0; left: 0;
		    width: 100%; height: 100%;
		    background-color: rgba(0,0,0,0.5);
		    display: flex; justify-content: center; align-items: center;
		    z-index: 9999;
		}
		.modal-content {
		    background: white;
		    padding: 20px;
		    border-radius: 10px;
		    width: 300px;
		}
		.fechar {
		    float: right;
		    font-size: 20px;
		    cursor: pointer;
		}	
		</style>
</head>
<body>

<header>
	<h1>Mesa pronta</h1>
	<div class="cabecalho">
		<a href="perfilRestaurante.jsp"><img src="imagens/perfil.png"  class="cabecalhoimagem"></a>
		<a href=""><img src="imagens/configuracoes.png" class="cabecalhoimagem"></a>
	</div>
</header>

<main>
<section class="container1">
	<section class="lotacao">
	
		<%		
		    restaurante infoRestaurante = null;
		
		    if (restauranteId != null) {
		        buscarLotacao buscadorLotacao = new buscarLotacao();
		
		        try {
		            infoRestaurante = buscadorLotacao.obterLotacaoPorRestauranteId(restauranteId);
		        } catch (SQLException e) {
		            out.println("<p>Erro ao buscar lotação: " + e.getMessage() + "</p>");
		        }
		    }
		%>	
	    <% if (infoRestaurante != null) { %>
	        <p>Lugares solicitados: <%= infoRestaurante.getLotacao() %> / <%= infoRestaurante.getCapacidadeMaxima() %></p>
	    <% } else { %>
	        <p>Dados de lotação não disponíveis.</p>
	    <% } %>
	</section>
	
	<section class="cardapio">
		<a href="verificarMenu" class="botao-aceitar">Configurar cardápio</a>
	</section>
</section>	
	<section class="container">
		<section class="reservas_pendentes">
			<h1>Reservas solicitadas</h1>
			<% if (reservas != null && !reservas.isEmpty()) { 
			     boolean encontrou = false;
			%>
		        <% for (reserva r : reservas) { 
		               if ("Aguardando a confirmação do restaurante".equals(r.getStatus())) {
		                   encontrou = true;
		        %>
			          <div class="reserva_pendente">
			              <p>Nome: <%= r.getNomeReserva() %></p>
			              <p><%= r.getHorarioReserva() %></p>
			              <p>Para <%= r.getNumeroPessoas() %> pessoas</p>
			              <a href="confirmarReserva.jsp?id=<%= r.getReservaId() %>" class="botao-aceitar">Aceitar</a>
			          </div>
		        <%     } // fim do if interno 
		             } // fim do for
		           if (!encontrou) { 
		        %>
		           <p>Nenhuma reserva encontrada para o restaurante informado.</p>
		        <% } 
			   } else { %>
			    <p>Nenhuma reserva encontrada para o restaurante informado.</p>
			<% } %>
		</section>		
		
		<section class="reservas_ativas">
			<h1>Reservas ativas</h1>
			<% if (reservas != null && !reservas.isEmpty()) { 
			     boolean encontrou = false;
			%>
		        <% for (reserva r : reservas) { 
		               if ("Reserva confirmada aguardando chegada".equals(r.getStatus()) || "confirmada".equals(r.getStatus())) {
		                   encontrou = true;
		        %>
					<div class="reserva_pendente" id="reserva_<%= r.getReservaId() %>">
					    <p>Nome: <%= r.getNomeReserva() %></p>
					    <p><%= r.getHorarioReserva() %></p>
					    <p>Para <%= r.getNumeroPessoas() %> pessoas</p>
					    
					    <% if ("Reserva confirmada aguardando chegada".equals(r.getStatus())) { %>
					        <button onclick="abrirPopup('<%= r.getReservaId() %>')" id="btnChegada_<%= r.getReservaId() %>" class="botao-aceitar">Confirmar Chegada</button>
					    <% } else if ("confirmada".equals(r.getStatus())) { %>

							<button type="button" onclick="abrirPopupSaida('<%= r.getReservaId() %>')" class="botao-aceitar">
							    Confirmar Saída
							</button>


					    <% } %>
					</div>


		</section>
</section>

</main>

<footer>
</footer>

<div id="popupConfirmacao" style="display:none; position:fixed; top:50%; left:50%; transform:translate(-50%,-50%);
 background:white; padding:20px; border:1px solid #ccc; z-index:1000;">
    <h3>Confirmar Chegada</h3>
    
    <form id="formConfirmacao" onsubmit="enviarConfirmacao(event)">
        <input type="hidden" id="reservaId" name="reservaId">
        <label for="codigo">Código de Confirmação:</label><br>
        <input type="text" id="codigo" name="codigo" required><br><br>
        <button type="submit">Enviar</button>
        <button type="button" onclick="fecharPopup()">Cancelar</button>
    </form>
    
</div>

<!-- Pop-up de confirmação de saída -->
<div id="popupConfirmarSaida" style="display:none; position:fixed; z-index:999; top:50%; left:50%; transform:translate(-50%,-50%); background:#fff; padding:20px; border-radius:10px; box-shadow:0 0 15px rgba(0,0,0,0.3);">
    <h3>Confirmar Saída</h3>
	<p id="textoConfirmacaoSaida"></p>
	
    <form id="formConfirmarSaida" method="POST" action="confirmarSaida">
        <input type="hidden" name="reservaId" id="reservaIdSaida">
        <p>Confirmar a saída da reserva em nome de:  <%= r.getNomeReserva() %> ?</p>
        <button type="submit">Confirmar</button>
        <button type="button" onclick="fecharPopupSaida()">Cancelar</button>
    </form>
    
</div>
		        <%     }  
		             } 
		           if (!encontrou) { 
		        %>
		           <p>Nenhuma reserva confirmada encontrada.</p>
		        <% } 
			   } else { %>
			    <p>Nenhuma reserva confirmada encontrada.</p>
			<% } %>
<!-- Fundo escurecido -->
<div id="fundoEscuro" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%;
 background:rgba(0,0,0,0.5); z-index:999;" onclick="fecharPopup()"></div>
 
 <!-- Fundo escurecido para confirmação de saída -->
<div id="fundoEscuroSaida" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%;
 background:rgba(0,0,0,0.5); z-index:998;" onclick="fecharPopupSaida()"></div>
 
 <script>
    function abrirPopup(reservaId) {
        document.getElementById('reservaId').value = reservaId;
        document.getElementById('popupConfirmacao').style.display = 'block';
        document.getElementById('fundoEscuro').style.display = 'block';
    }

    function fecharPopup() {
        document.getElementById('popupConfirmacao').style.display = 'none';
        document.getElementById('fundoEscuro').style.display = 'none';
    }

    function enviarConfirmacao(event) {
        event.preventDefault();

        const reservaId = document.getElementById('reservaId').value;
        const codigo = document.getElementById('codigo').value;

        fetch('confirmarChegada', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams({ reservaId, codigo })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert("Chegada confirmada com sucesso!");
                location.reload(); // atualiza a página
            } else {
                alert(data.message || "Erro ao confirmar chegada.");
            }
        })
        .catch(err => {
            alert("Erro na requisição.");
            console.error(err);
        });

        fecharPopup();
    }
    function abrirPopupSaida(reservaId) {
        document.getElementById('reservaIdSaida').value = reservaId;
        document.getElementById('popupConfirmarSaida').style.display = 'block';
        document.getElementById('fundoEscuroSaida').style.display = 'block';
    }


    function fecharPopupSaida() {
        document.getElementById('popupConfirmarSaida').style.display = 'none';
        document.getElementById('fundoEscuroSaida').style.display = 'none';
    }
</script>
</body>
</html>
