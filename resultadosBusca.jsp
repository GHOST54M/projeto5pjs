<%@ page import="java.util.ArrayList" %>
<%@ page import="bancodedados.restaurante" %>

<html>
<head>
        <meta name="viewport" content="width=device-width, initial-scale=1">       
		<meta charset="UTF-8">
		
		<link rel="stylesheet" type="text/css" href="css/reset.css">
		<link rel="stylesheet" type="text/css" href="css/estilosRepetidos.css">
		
		<title></title>

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
		
		.titulo{
			font-size: 30px;
			text-align: center;
			margin:30px;
		}
		
		.container{
			display:flex;
    		justify-content: center;
    		margin-top: 50px;
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
	    
	    .listaDeRestaurantes{
			border: 2px solid #831D1C;
			box-shadow: 2px 2px 2px 1px rgba(0, 0, 0, 0.2);	
			padding: 20px;	
			width: 900px;    
	    }
	    
		.restaurante {
		    display: flex;
		    justify-content: space-between; 
		    align-items: center;            
		    padding: 10px;
		    margin-bottom: 15px;
		}
		
		.info-restaurante {
		    display: flex;
		    align-items: center;
		}
		
		.nome_restaurante, .EspecialidadeGastronomica {
		    margin-left: 20px;
		    font-size: 26px;
		}
		.nome_restaurante{
			width:250px;
		}
		.EspecialidadeGastronomica{
		    border-left: 2px solid grey;
		    padding-left: 20px;
		}
		
		.botao {
		    padding: 10px 20px;
		    background-color: #831D1C;
		    color: #FFFFFF;
		    text-decoration: none;
		    border-radius: 5px;
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
	<section class="container">
		<%
		    ArrayList<restaurante> restaurantes = (ArrayList<restaurante>) request.getAttribute("restaurantesEncontrados");
		%>
		<a href="paginaPrincipalUsuario.jsp"><button class="back-button">&#8592;</button></a>
		
		<section class="listaDeRestaurantes">	
		
			<% if (restaurantes != null && !restaurantes.isEmpty()) { %>
			    <% for (restaurante r : restaurantes) { %>
				<div class="restaurante">
				    <div class="info-restaurante">
				        <img src="<%= r.getFotoPerfil() %>" alt="Foto de <%= r.getNome() %>" width="80" height="80">
				        <h2 class="nome_restaurante"><%= r.getNome() %></h2>
				        <p class="EspecialidadeGastronomica"><%= r.getEspecialidadeGastronomica() %></p>
				    </div>
				    <a href="detalhesRestaurante.jsp?id=<%= r.getRestauranteId() %>" class="botao">Ver detalhes</a>
				</div>
			    <% } %>
			<% } else { %>
			    <p>Nenhum restaurante encontrado com esse nome.</p>
			<% } %>
		</section>
	</section>
</main>
<footer>
</footer>
</body>
</html>