<%@ page import="java.util.*, bancodedados.restaurante, bancodedados.exibirRestaurantes, bancodedados.buscarHorarios" %>
<%@ page import="bancodedados.itemMenu, bancodedados.exibirCardapio" %>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">       
	<meta charset="UTF-8">
		
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" type="text/css" href="css/estilosRepetidos.css">
		
    <title>Detalhes do Restaurante</title>

    <style>
    	body{
        	font-family: Arial, sans-serif;
    
    	}
    	
 		header {
			position: relative;
			display: flex;
			justify-content: center; 
			align-items: center;
			height: 100px; 
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
			width: 50px; 
			height: 50px;
			margin-right: 20px;
		}
		
		.container{
			display: flex;
    		justify-content: center;
    		margin-top:20px;		
		}
		
		.area_dados_do_restaurante{
		    width: 1100px;
	    	display: flex;
	    	margin-top:20px;
	    	margin-left: 5px;
	    	flex-direction: column;
    		align-items: center;  
    		border: 2px solid #831D1C;
			box-shadow: 2px 2px 2px 1px rgba(0, 0, 0, 0.2); 
			margin-bottom: 40px;	
    	}
    	.conteudo_restaurante{
	    	display: flex;    	
    	}
		.back-button {
      		background-color: #771b1b;
      		color: white;
      		border: none;
      		padding: 10px;
     		border-radius: 5px;
      		cursor: pointer;
    	}

	    .back-button:hover {
	      	background-color: #5e1515;
	    }
        .detalhes-restaurante {
        	width:1000px;
		    margin: 30px;
		    padding: 10px;
		    display:flex;
		}
		.detalhes-restaurante{
		 justify-content: flex-start;
		
		}

        .detalhes-restaurante img {
            width: 200px;
            height: 200px;
            border-radius: 10px;
        }
        
		.grupo-cardapio {
		    margin-bottom: 30px;
		}
		
		.grupo-cardapio h2 {
		    font-size: 24px;
		    margin-bottom: 10px;
		    border-bottom: 2px solid #ccc;
		    padding-bottom: 5px;
		    color: #333;
		}
		
		.item-cardapio {
		    display: flex;
		    margin-bottom: 15px;
		    background-color: #f9f9f9;
		    border: 1px solid #ddd;
		    border-radius: 6px;
		    padding: 10px;
		}
		
		.item-cardapio img {
		    width: 120px;
			height: 120px;
		    margin-right: 15px;
		    border-radius: 5px;
		}
		
		.item-info h3 {
		    margin: 0 0 5px;
		}
		
		.item-info p {
		    margin: 3px 0;
		}

        
        .info{
        	padding-left: 20px;
        }
        .info > * {
			margin-bottom:10px;
			
        }
        .info > h1{
        	font-size:20px;
        	font-weight:700;
        }
        .desc{
        padding-left:15px;
        }
        		
		.area_reserva{
			margin: 30px;
		    padding: 10px;	
		}
		.area_reserva > form {
			font-size: 20px;
			
		}
		.area_reserva > form > input{
		    border: 2px solid #831D1C;
		    padding: 5px;
		    font-size: 20px;
		
		}
		.quantidadePessoas{
			width: 40px;
		}
		.alinhamento{
			margin-top:20px;
			display:flex;
			justify-content: space-around;
		}
        .aviso{
 		color: red;
    	font-size: 14px;
    	width: 250px;       
        }
        
        .btn-reserva{
       	background-color: #831D1C;
        text-decoration: none;
        color: #FFFFFF;
        padding: 10px;
    	font-size: 20px;
    	border:none;
		cursor: pointer;        
        }
    </style>
</head>
<body>
<header>
	<h1>Mesa Já</h1>

	<div class="cabecalho">
		<a href="visualizar_reserva.jsp"><img src="imagens/prato.png"  class="cabecalhoimagem"></a>		
		<a href="perfilUsuario.jsp"><img src="imagens/perfil.png"  class="cabecalhoimagem"></a>
		<a href=""><img src="imagens/configuracoes.png" class="cabecalhoimagem"></a>
	</div>
</header>
<main>
	<%
	    String idParam = request.getParameter("id");
	    if (idParam != null) {
	        try {
	            int id = Integer.parseInt(idParam);
	            exibirRestaurantes dao = new exibirRestaurantes();
	            restaurante r = dao.buscarRestaurantePorId(id); // Método que você precisa implementar no DAO
	
	            if (r != null) {
	%>
	<section class="container">
	<a href="paginaPrincipalUsuario.jsp"><button class="back-button">&#8592;</button></a>

	<section class="area_dados_do_restaurante">
		
		
			<div class="conteudo_restaurante">
				
			    <div class="detalhes-restaurante">
			        <img src="<%= r.getFotoPerfil() %>" alt="Foto de <%= r.getNome() %>">	
			        
			        <div class="info">
			        <h1><%= r.getNome() %></h1>	
			            <p><%= r.getEspecialidadeGastronomica() %></p>
						<%
						    buscarHorarios.HorarioFuncionamento horario = new buscarHorarios().buscarHorarioDoDia(idParam); // Supondo que r.getId() retorne o restaurante_id
						    if (horario != null) {
						%>
						    <p>Abre: <%= horario.getHoraAbertura() %></p>
						    <p>Fecha: <%= horario.getHoraFechamento() %></p>
						<%
						    } else {
						%>
						    <p>Horário de funcionamento não disponível para hoje.</p>
						<%
						    }
						%>
			            <p><strong>Máximo de pessoas por reserva:</strong> <%= r.getMaxReserva() %></p>
			        </div>
			        <div class="desc">
			        <p><%= r.getDescricao() %></p>
			        </div>
			    </div>
			 </div>
			 
			 <div class="cardapio">
				<%
				    bancodedados.exibirCardapio cardapioDAO = new bancodedados.exibirCardapio();
				    List<bancodedados.itemMenu> itensMenu = cardapioDAO.buscarItensPorRestauranteId(id);
				
				    if (!itensMenu.isEmpty()) {
				        // Agrupar por tipo
				        Map<String, List<bancodedados.itemMenu>> itensPorTipo = new HashMap<>();
				
				        for (bancodedados.itemMenu item : itensMenu) {
				            String tipo = item.getTipoItem();
				            if (!itensPorTipo.containsKey(tipo)) {
				                itensPorTipo.put(tipo, new ArrayList<>());
				            }
				            itensPorTipo.get(tipo).add(item);
				        }
				
				        // Exibir grupos
				        for (Map.Entry<String, List<bancodedados.itemMenu>> grupo : itensPorTipo.entrySet()) {
				            String tipo = grupo.getKey();
				            List<bancodedados.itemMenu> itensDoTipo = grupo.getValue();
				%>
				        <div class="grupo-cardapio">
				            <h2><%= tipo %></h2>
				<%
				            for (bancodedados.itemMenu item : itensDoTipo) {
				%>
				            <div class="item-cardapio">
				                <img src="<%= item.getFotoItem() %>" alt="Foto de <%= item.getNomeItem() %>">
				                <div class="item-info">
				                    <h3><%= item.getNomeItem() %></h3>
				                    <p><%= item.getDescricaoItem() %></p>
				                    <p><strong>Preço:</strong> R$ <%= String.format("%.2f", item.getPrecoItem()) %></p>
				                </div>
				            </div>
				<%
				            } // fim dos itens do tipo
				%>
				        </div>
				<%
				        } // fim dos tipos
				    } else {
				%>
				    <p>Este restaurante ainda não possui itens no cardápio.</p>
				<%
				    }
				%>

		 
			 </div>
		 			<% 
		    String erroReserva = (String) request.getAttribute("erroReserva");
		    String erroHorario = (String) request.getAttribute("erroHorario");
		    String erroSistema = (String) request.getAttribute("erroSistema");
		    String erroMaxPessoas = (String) request.getAttribute("erroMaxPessoas");

		%>
		
		<% if (erroReserva != null) { %>
		    <div style="color: red;"><strong><%= erroReserva %></strong></div>
		<% } %>
		
		<% if (erroHorario != null) { %>
		    <div style="color: red;"><strong><%= erroHorario %></strong></div>
		<% } %>
		
		<% if (erroSistema != null) { %>
		    <div style="color: red;"><strong><%= erroSistema %></strong></div>
		<% } %>
		<% if (erroMaxPessoas != null) { %>
    <div style="color: red;"><strong><%= erroMaxPessoas %></strong></div>
	<% } %>	
			 <div class="area_reserva">
	    		<form action="agendarReserva" method="post">
		            <label>Reserva para</label>
		            <input type="number" name="quantidadePessoas" min="1" max="<%= r.getMaxReserva() %>" required class="input-inline quantidadePessoas"/>
		            pessoas.
		            
		            
		            <span>Nome na reserva</span>
		            <input type="text" name="nomeReserva" required />
		        	
		    		<input type="hidden" name="id" value="<%= r.getRestauranteId() %>">
		
		  
		            <label>Horário reserva</label>
		            <input type="time" name="horarioReserva" required />
		            
		            <div class="alinhamento">
			        <div class="aviso">
		            O restaurante tolera até 15 minutos de atraso caso ninguém da reserva tenha chegado.
		        	</div>	
		        	   			
		            <button type="submit" class="btn-reserva">Realizar reserva</button>
		        	</div>
		        	
				</form>
			            		
	    	</div>
		  		
		
	<%
	            } else {
	%>
	    <p>Restaurante não encontrado.</p>
	<%
	            }
	        } catch (NumberFormatException e) {
	%>
	    <p>ID inválido.</p>
	<%
	        }
	    } else {
	%>
	    <p>ID do restaurante não fornecido.</p>
	<%
	    }
	%>
	</section>
</section>
</main>
<footer>
</footer>
</body>
</html>
