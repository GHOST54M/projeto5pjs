<!DOCTYPE html>
<%@ page import="java.util.List" %>
<%@ page import="bancodedados.restaurante" %>
<%@ page import="bancodedados.exibirRestaurantes" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>

        <meta name="viewport" content="width=device-width, initial-scale=1">       
		<meta charset="UTF-8">
		
		<link rel="stylesheet" type="text/css" href="css/reset.css">
		<link rel="stylesheet" type="text/css" href="css/estilosRepetidos.css">
	
		<title>Cadastro VENano</title>
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

		.formulario, .conteudo{
		    display: flex;
    		flex-direction: column;
    		align-items: center;
		}
				
		.barra_de_pesquisa{
		margin-top: 20px;
		margin-bottom: 40px;		
		}
		
		.barra{
		
		width: 450px;
		height: 50px;
		padding:5px;
		font-size: 20px;
		border: 2px solid #831D1C;
		box-shadow: 2px 2px 2px 1px rgba(0, 0, 0, 0.2);
		}
		
		.container {
		  display: flex;
		  gap: 30px;
		  justify-content: center;
		  flex-wrap: wrap;
		}
		
		.card {
		  background-color: white;
		  border: 1px solid #831D1C;
		  box-shadow: 0 3px 6px rgba(0,0,0,0.1);
		  padding: 16px;
		  width: 230px;
		  text-align: center;
		}
		
		.card h2 {
		  font-size: 20px;
		  margin-bottom: 12px;
		}
		
		.card img {
		  width: 100%;
		  height: 140px;
		  object-fit: cover;
		  margin-bottom: 16px;
		}
		
		.card button {
		  background-color: #831D1C;
		  color: white;
		  border: none;
		  padding: 10px 16px;
		  font-size: 14px;
		  cursor: pointer;
		  transition: background-color 0.3s ease;
		}
		
		.card button:hover {
		  background-color: #a30000;
		}
		
		.area_lista_restaurantes{
		margin: 30px;
		}
		
		.area_lista_restaurantes > h2{
		font-size:28px;
		}
		
		.lista_restaurantes{
		display: flex;
    	justify-content: center;
		}
		
		.restaurante{
		margin:20px;
		padding:20px;
		border: 1px solid #831D1C;
		box-shadow: 0 3px 6px rgba(0,0,0,0.1);
		display:flex;
	    flex-direction: column;
	    align-items: center;
		}
		
		.nome_restaurante{
		font-size:21px;
		margin-bottom:10px;
		}
		
		.botao{
		padding: 10px;
		background-color: #831D1C;
		color: #FFFFFF;
		
		}
		
		</style>
</head>
<body>

<header>
	<h1>Mesa pronta</h1>

	<div class="cabecalho">
		<a href="visualizar_reserva.jsp"><img src="imagens/prato.png"  class="cabecalhoimagem"></a>		
		<a href="perfilUsuario.jsp"><img src="imagens/perfil.png"  class="cabecalhoimagem"></a>
		<a href=""><img src="imagens/configuracoes.png" class="cabecalhoimagem"></a>
	</div>
</header>

<main>	

	<section class="barra_de_pesquisa">
	<div class="container">
		<form action="buscarRestaurantePorNome">
			<input type="text" name="pesquisa" class="barra" placeholder="Procurar restaurante...">
		</form>
	</div>
	</section>
	
	<section class="classificar_por_culinaria">
	  <div class="container">
	  
				<div class="card">
			      <h2>Comida brasileira</h2>
			      <img src="imagens/culinariaBrasileira.png" alt="Comida brasileira">
				  <form action="procurarRestaurantePorGastronomia" method="post">
				  <input type="hidden" name="especialidade" value="Brasileira">
				  <button type="submit">Ver restaurantes</button>
				</form>
			    </div>
			    
			    <div class="card">
			      <h2>Comida italiana</h2>
			      <img src="imagens/culinariaBrasileira.png" alt="Comida italiana">
			      <form action="procurarRestaurantePorGastronomia" method="post">
				  <input type="hidden" name="especialidade" value="Italiana">
				  <button type="submit">Ver restaurantes</button>
				  </form>
			    </div>
			    
			    <div class="card">
			      <h2>Comida árabe</h2>
			      <img src="imagens/culinariaBrasileira.png" alt="Comida árabe">
				  <form action="procurarRestaurantePorGastronomia" method="post">
				  <input type="hidden" name="especialidade" value="Árabe">
				  <button type="submit">Ver restaurantes</button>
				  </form>			    
				</div>
			    
			    <div class="card">
			      <h2>Comida japonesa</h2>
			      <img src="imagens/culinariaBrasileira.png" alt="Comida japonesa">
				  <form action="procurarRestaurantePorGastronomia" method="post">
				  <input type="hidden" name="especialidade" value="Japonesa">
				  <button type="submit">Ver restaurantes</button>
				  </form>			      
			  </div>
		  </div>
	</section>
	<section class="area_lista_restaurantes">
	<h2>Melhor avaliados</h2>
			<section class="lista_restaurantes">
			    <%
			    	exibirRestaurantes dao = new exibirRestaurantes();
			        List<restaurante> lista = dao.listarRestaurantes();
			
			        for (restaurante r : lista) {
			    %>
			        <div class="restaurante">
			            <h2 class="nome_restaurante"><%= r.getNome() %></h2>
			            <img src="<%= r.getFotoPerfil() %>" alt="Foto de <%= r.getNome() %>" width="150" height="150"><br>
			            <a href="detalhesRestaurante.jsp?id=<%= r.getRestauranteId() %>" class="botao">Ver detalhes</a>
			        </div>
			    <%
			        }
			    %>	
			</section>
	</section>
	<section class="classificar_por_ultimos_restaurantes">
	
	</section>

</main>

<footer>
</footer>

</body>
</html>