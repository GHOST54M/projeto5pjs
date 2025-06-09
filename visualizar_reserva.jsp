<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="bancodedados.reserva" %> 
<%@ page import="bancodedados.buscarReserva" %> 
<%@ page import="jakarta.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">       
    <meta charset="UTF-8">
    		
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" type="text/css" href="css/estilosRepetidos.css">
	
    <title>Minhas Reservas</title>
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
		.container{
			display: flex;
    		justify-content: center;
    		margin-top: 20px;		
		}
	    .back-button {
	      background-color: #771b1b;
	      color: white;
	      border: none;
	      padding: 10px;
	      border-radius: 5px;
	      cursor: pointer;
	      margin-right:20px;
	    }
	
	    .back-button:hover {
	      background-color: #5e1515;
	    }
		.detalhes_reserva{
		    width: 500px;
		    height: 400px;
			border: 2px solid #831D1C;
			box-shadow: 2px 2px 2px 1px rgba(0, 0, 0, 0.2);	
			padding: 10px;
		    display: flex;
		    flex-direction: row;
		    flex-direction: column;
    		justify-content: space-between;
		}
		.status{
		font-size: 26px;
		font-weight:700;
		}
		.nome, .horario, .pessoas, .data,.endereco{
		font-size: 20px;	
		}
		.areacodigo{
		font-size: 26px;
		font-weight:700;
		color: green;		
		}
		.btn-cancelar {
	      color: #831D1C;
	      border: 1px solid #831D1C;
	      background-color: transparent;
	      padding: 10px 20px;
	      font-size: 24px;
	      cursor: pointer;
	      text-decoration: none;
	      border-radius: 4px;
	      display: inline-block;
		  max-width:130px;
	      margin-left: auto;
	      margin-right: auto;
	      
    }

	    .btn-cancelar:hover {
	      background-color: #f8d7da;
	    }
		.popup {
		    display: none;
		    position: fixed;
		    top: 0; left: 0;
		    width: 100%; height: 100%;
		    background-color: rgba(0, 0, 0, 0.5);
		    justify-content: center;
		    align-items: center;
		    z-index: 999;
		}
		
		.popup-conteudo {
		    background: white;
		    padding: 20px;
		    border-radius: 10px;
		    text-align: center;
		    min-width: 300px;
		}
		
		.popup-botoes button {
		    margin: 10px;
		    padding: 10px 20px;
		    cursor: pointer;
		}
    </style>
</head>
<body>
<header>
	<div class="cabecalho">
		<a href="perfilUsuario.jsp"><img src="imagens/perfil.png"  class="cabecalhoimagem"></a>
		<a href=""><img src="imagens/configuracoes.png" class="cabecalhoimagem"></a>
	</div>
</header>
<section class="container">
 		 <a href="paginaPrincipalUsuario.jsp"><button class="back-button">&#8592;</button></a>
  
    <%
        if (session == null || session.getAttribute("userId") == null) {
    %>
        <p>Você precisa estar logado para visualizar suas reservas.</p>
    <%
        } else {
            int clienteId = (int) session.getAttribute("userId");

            List<reserva> reservas = null;
            try {
            	buscarReserva dao = new buscarReserva();
                reservas = dao.listarReservasDoCliente(clienteId);
            } catch (Exception e) {
                out.println("<p>Erro ao carregar reservas: " + e.getMessage() + "</p>");
            }

            if (reservas == null || reservas.isEmpty()) {
    %>
                <p>Você não possui reservas.</p>
    <%
            } else {
    %>

                        <% for (reserva r : reservas) { %>
                        
                        <section class="detalhes_reserva">
                                <div class="status"><%= r.getStatus() %></div>
                                <div class="nome">Reserva em: <%= r.getNomeRestaurante() %></div>                              
                                <div class="nome">Nome da reserva: <%= r.getNomeReserva() %></div>
                                <div class="horario">Horário: <%= r.getHorarioReserva() %></div>
                                <div class="pessoas">Número de pessoas: <%= r.getNumeroPessoas() %></div>
                                         	                                                                                   
                                <div class="data">Data da reserva: <%= r.getDataReserva() %></div>
                                <div class="endereco">Endereço: <%= r.getRuaRestaurante() %>, <%= r.getNumeroRestaurante() %> CEP: <%= r.getCepRestaurante() %> </div>
                             	<div class="areacodigo">Código de confirmação: <%= r.getCodigoConfirmacao() %></div>
                             	
						    <a href="#" class="btn-cancelar" onclick="abrirPopup(event)">Cancelar</a>
						</section>
						
						<div id="popup-confirmacao" class="popup">
						    <div class="popup-conteudo">
						        <p>Deseja realmente cancelar a reserva?</p>
						        <div class="popup-botoes">
						            <form action="cancelarReserva.jsp?id=<%= r.getReservaId() %>" method="post">
						                <button type="submit">Sim</button>
						            </form>
						            <button onclick="fecharPopup()">Não</button>
						        </div>
						    </div>
						</div>
                        <% } %>

    <%
            }
        }
    %>
</section>
	<script>
	function abrirPopup(event) {
	    event.preventDefault(); // Impede o link de ir para a página
	    document.getElementById("popup-confirmacao").style.display = "flex";
	}
	
	function fecharPopup() {
	    document.getElementById("popup-confirmacao").style.display = "none";
	}
	</script>
</body>
</html>
