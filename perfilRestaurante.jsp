<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="bancodedados.restaurante" %>
<%@ page import="bancodedados.buscarRestaurante" %>
<%@ page import="java.sql.SQLException" %>
<%
    Integer restauranteId = (Integer) session.getAttribute("restauranteId");
    restaurante Restaurante = null;

    if (restauranteId != null) {
        try {
        	buscarRestaurante buscar = new buscarRestaurante();
            Restaurante = buscar.getRestaurantePorId(restauranteId);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    } else {
        response.sendRedirect("login_restaurante.jsp?erro=Restaurante+não+autenticado");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
        <meta name="viewport" content="width=device-width, initial-scale=1">       
		<meta charset="UTF-8">
		
		<link rel="stylesheet" type="text/css" href="css/reset.css">
		<link rel="stylesheet" type="text/css" href="css/estilosRepetidos.css">
	
    <title>Mesa Já</title>
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

		.dadosusuario{	
			display: inline-block;
      		text-align: left;
    	}	
    	
    	.area_dados_usuario{
	    	display: flex;
	    	justify-content: center;
	    	margin-top:20px;   	
    	}
         h2{
        	font-size: 24px;
        	margin-bottom: 15px;
        }   	
    	.back-button {
	      background-color: #771b1b;
	      color: white;
	      border: none;
	      padding: 10px;
	      border-radius: 5px;
	      cursor: pointer;
	    }
	    		
        .formUsuario {
            width: 600px;
            margin: 10px;
            padding: 20px;
            box-shadow: 0px 4px 5px 0px rgba(168,164,164,1);
			-webkit-box-shadow: 0px 4px 5px 0px rgba(168,164,164,1);
			-moz-box-shadow: 0px 4px 5px 0px rgba(168,164,164,1);
			display: flex;
    		flex-direction: column;
    		margin-bottom: 40px;
        }
        .imagem-perfil{
        	width:150px;
        	height:150px;
        	margin:10px;
        }
        .formUsuario label {
            font-weight: bold;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        
        .formUsuario input {
			margin: 10px;
			padding: 5px;
			font-size: 18px;
        }
        
        .formUsuario button {
            padding: 10px 20px;
            margin-top: 10px;
        }
        
        .input-padrao{
        width: 500px;
        }
        
        .telefones, .capacidades{
  		display: flex;
    	justify-content: flex-start; 
    	   
        }
        .telefones > div, .capacidades > div{
        margin-right: 20px;
        }
        
        .telefone{
        width: 110px;
        }
        
        textarea {
            width: 100%;
            margin: 5px 0 10px 0;
            padding: 5px;
            border: 1px solid #7b1c1c;
            box-sizing: border-box;
        }
        
        textarea {
            height: 80px;
        }
        
        .capacidade{
			width: 50px;         
        }
	     .localizacao{
	     display: flex;
	     }
	        
		.botoes{
		display: flex;
    	justify-content: space-evenly;
		}
		
		.botoes > .botao{
		width:150px;
		border:none;
		cursor: pointer;
		
		}
        .botao{
        width:150px;
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
		<a href="perfilRestaurante.jsp"><img src="imagens/perfil.png"  class="cabecalhoimagem"></a>
		<a href=""><img src="imagens/configuracoes.png" class="cabecalhoimagem"></a>
	</div>
</header>
	    <script>
        function toggleEdit() {
            const inputs = document.querySelectorAll("#userForm input[type='text']");
            inputs.forEach(input => input.removeAttribute("readonly"));
            
            const textarea = document.querySelectorAll("#userForm textarea");
            textarea.forEach(textarea => textarea.removeAttribute("readonly"));
            
            document.getElementById("editButton").style.display = "none";
            document.getElementById("submitButton").style.display = "inline";
        }

        function validateForm() {
            // Adicione validações se necessário
            return true;
        }
    </script>
<main>
	<section class="area_dados_usuario">
	<div  class="dados_usuario">
		<a href="paginaPrincipalRestaurante.jsp"><button class="back-button">&#8592;</button></a>
		<form id="userForm" action="editarRestaurante" method="POST" onsubmit="return validateForm()" class="formUsuario">
		        <h2>Dados do Restaurante</h2>
				<img src="<%= Restaurante.getFotoPerfil() %>" class="imagem-perfil">
				<input type="hidden" id="id" name="id" value="<%= Restaurante.getRestauranteId() %>" >
		
		        <label for="nome" class="nome">Nome:</label>
		        <input type="text" id="nome" name="nome" value="<%= Restaurante.getNome() %>" readonly class="input-padrao">
		
		        <label for="email" class="email">Email:</label>
		        <input type="text" id="email" name="email" value="<%= Restaurante.getEmail() %>" readonly class="input-padrao">
		        
		        <label for="cnpj" class="cnpj">CNPJ:</label>
		        <input type="text" id="cnpj" name="cnpj" value="<%= Restaurante.getCnpj() %>" readonly class="input-padrao">
		        
		        <div class="telefones">
		        		
		        <div>	        
		        	<label for="telefone">Telefone 1:</label>
		        	<input type="text" id="telefone1" name="telefone1" value="<%= Restaurante.getTelefone1() %>" class="telefone" readonly>
		        </div>
		        
		        <div>    
		        	<label for="telefone">Telefone 2:</label>
		        	<input type="text" id="telefone2" name="telefone2" value="<%= Restaurante.getTelefone2() %>" class="telefone" readonly>	
		        </div>	  
				</div>
									
				<label for="descricao" class="descricao">Descrição:</label>
				<textarea id="descricao" name="descricao" readonly><%= Restaurante.getDescricao() %></textarea>
				
				<div class="capacidades">
		        		
		        <div>
			       	<label for="capacidade" class="capacidade">Capacidade máxima:</label>
			        <input type="text" id="capacidade" name="capacidade" value="<%= Restaurante.getCapacidadeMaxima() %>"class="capacidade" readonly>
				</div>
				<div>
			       	<label for="maxReserva" class="maxReserva">Máximo de pessoas por reserva:</label>
			        <input type="text" id="maxReserva" name="maxReserva" value="<%= Restaurante.getMaxReserva() %>"class="capacidade" readonly>
		        </div>
		        
		        </div>
		        
		        <div class="localizacao">
		        <div>
		       		<label for="UF" class="UF">UF:</label>
		        	<input type="text" id="UF" name="uf" value="<%= Restaurante.getUf() %>"class="uf" readonly>
				</div>
				
				<div>
		       		<label for="municipio" class="municipio">Município:</label>
		        	<input type="text" id="municipio" name="municipio" value="<%= Restaurante.getMunicipio() %>"class="municipio" readonly>
		        </div>
		        </div>
		        
		        <div class="localizacao">			
				<div>
		       		<label for="Rua" class="Rua">Rua:</label>
		        	<input type="text" id="Rua" name="Rua" value="<%= Restaurante.getRua() %>"class="rua" readonly>
		        </div>	       
		        		        
				<div>
		       		<label for="CEP" class="CEP">CEP:</label>
		        	<input type="text" id="CEP" name="CEP" value="<%= Restaurante.getCep() %>"class="cep" readonly>
		        </div>
		        		        		        
		        </div>		        
				<div class="botoes">

			    <button type="button" id="editButton" onclick="toggleEdit()" class="botao">Editar</button>
			    <button type="submit" id="submitButton" style="display: none;" class="botao">Salvar Alterações</button>			    
				<button type="button" class="botao" onclick="window.location.href='logout'">Sair</button>

		   		</div>
		</form>
		</div>
	</section>
</main>
    
<footer>
</footer>

</body>
</html>
