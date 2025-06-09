<%@ page import="java.util.*, bancodedados.restaurante, bancodedados.exibirRestaurantes, bancodedados.buscarHorarios" %>
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
        .detalhes-restaurante ,.area_reserva {
        	width: 1000px;
		    margin: 30px;
		    padding: 10px;
            font-family: Arial, sans-serif;
            display:flex;
        	justify-content: flex-start;

		}
        .detalhes-restaurante img {
            width: 200px;
            height: 200px;
            border-radius: 10px;
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
    </style>
</head>
<body>
<header>
	<div class="cabecalho">
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
			 </div>
		 
			 <div class="area_reserva">
	    		<form action="agendarReserva" method="post">
		            <label>Reserva para</label>
		            <input type="number" name="quantidadePessoas" min="1" required class="input-inline" />
		            pessoas.
		            <span>Nome na reserva</span>
		            <input type="text" name="nomeReserva" required />
		        
		    		<input type="hidden" name="id" value="<%= r.getRestauranteId() %>">
		
		  
		            <label>Horário reserva</label>
		            <input type="time" name="horarioReserva" required />
		   
		            <button type="submit" class="btn-reserva">Realizar reserva</button>
		        
				</form>
		        <div class="aviso">
		            O restaurante tolera até 15 minutos de atraso caso ninguém da reserva tenha chegado.
		        </div>			            		
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
