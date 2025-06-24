<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="bancodedados.cliente" %>
<%@ page import="bancodedados.buscarCliente" %>
<%@ page import="java.sql.SQLException" %>
<%
    Integer clienteId = (Integer) session.getAttribute("userId");
    cliente Cliente = null;

    if (clienteId != null) {
        try {
            buscarCliente buscar = new buscarCliente();
            Cliente = buscar.getClientePorId(clienteId);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    } else {
        response.sendRedirect("login_cliente.jsp?erro=Cliente+não+autenticado");
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
		main{
			margin-bottom: 40px;
		}
		.dadosusuario{	
			display: inline-block;
      		text-align: left;
    	}	
    	
    	.area_dados_usuario{
	    	display: flex;
	    	flex-direction: column;
   			align-items: center;
	    	margin-top:20px;   	
    	}
    	
    	.back-button {
	      background-color: #831D1C;
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
        }
        
        .formUsuario label {
            font-weight: bold;
        }
        
        .formUsuario input {
            width: 90%;
            padding: 8px;
            margin-bottom: 10px;
        }
        
        .formUsuario button {
            padding: 10px 20px;
            margin-top: 10px;
        }
        .assinatura{
        	display:flex;
        	flex-direction: column;
        	margin-top:20px;
        }
        
        h2{
        	font-size: 24px;
        	margin-bottom: 15px;
        }
        
        .assinatura-conteudo{
            display:flex;
            width: 750px;
    		justify-content: space-between;
		}
        
        .vantagens-assinatura{
         	width: 270px;
        	height: 220px;
        	margin:10px;
        	display: flex;
		    flex-direction: column;
		    justify-content: space-around;       
        }
        
        .plano{
        	width: 190px;
        	height: 190px;
        	margin:10px;
        
        }
        .plano{
        border: 2px solid #831D1C;
        padding: 15px;
        box-shadow: 0px 4px 5px 0px rgba(168,164,164,1);
		-webkit-box-shadow: 0px 4px 5px 0px rgba(168,164,164,1);
		-moz-box-shadow: 0px 4px 5px 0px rgba(168,164,164,1);
		display: flex;
	    flex-direction: column;
	    align-items: center;
	    justify-content: space-between;
        }
        .titulo-plano{
        font-size: 20px;
        }
        .area-preco{
        display: flex;
        align-items: center;
        }
        .preco{
        font-size: 24px;
        font-weight: 700;
        }
        
        .preco-detalhe{
        font-size: 12px;
            
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


        .error {
	    font-size: 0.9em;
	    color: red;
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
	    <script>
        function toggleEdit() {
            const inputs = document.querySelectorAll("#userForm input[type='text']");
            inputs.forEach(input => input.removeAttribute("readonly"));

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
		<a href="paginaPrincipalUsuario.jsp"><button class="back-button">&#8592;</button></a>
		<form id="userForm" action="editarCliente" method="POST" onsubmit="return validateForm()" class="formUsuario">
		    <h2>Dados do Usuário</h2>
				
		    <input type="hidden" id="id" name="id" value="<%= Cliente.getId() %>"><br>
		
		    <label for="nome">Nome:</label><br>
		    <input type="text" id="nome" name="nome" value="<%= Cliente.getNome() %>" readonly><br>
		    <span class="error" id="erroNome"></span><br>
		
		    <label for="email">Email:</label><br>
		    <input type="text" id="email" name="email" value="<%= Cliente.getEmail() %>" readonly><br>
		    <span class="error" id="erroEmail"></span><br>
		
		    <label for="telefone">Telefone:</label><br>
		    <input type="text" id="telefone" name="telefone" value="<%= Cliente.getTelefone() %>" readonly><br>
		    <span class="error" id="erroTelefone"></span><br>
		
		    <label for="Rua">Rua:</label><br>
		    <input type="text" id="Rua" name="Rua" value="<%= Cliente.getRua() %>" readonly><br>
		    <span class="error" id="erroRua"></span><br>
		
		    <label for="CEP">CEP:</label><br>
		    <input type="text" id="CEP" name="CEP" value="<%= Cliente.getCep() %>" readonly><br>
		    <span class="error" id="erroCep"></span><br>
		    
		    <div class="botoes">
		    <button type="button" id="editButton" onclick="toggleEdit()" class="botao">Editar</button>
		    <button type="submit" id="submitButton" style="display: none;" class="botao">Salvar Alterações</button>
		    
			<button type="button" class="botao" onclick="window.location.href='logout'">Sair</button>
		   	</div>
		</form>
		<script src="javascript/validarEdicaoCliente.js"></script>

		</div>
		<div class="assinatura">
		<h2>Assinatura premium</h2>
		<div class="assinatura-conteudo">
		
			<div class="vantagens-assinatura">
				<p>Integração com uber e 99.</p>
				<p>Realize pedidos enquanto você está a caminho!</p>
				<p>Chegue ao respeutante com seu pedido pronto!</p>
			</div>
			
			<div class="plano">
			<p class="titulo-plano">Plano mensal</p>
			<div class="area-preco">
			<p class="preco">R$ 24,99</p>
			<p class="preco-detalhe">/ao mes</p>
			</div>
			<button type="button" class="botao">Assinar</button>
			</div>
			
			<div class="plano">
			<p class="titulo-plano">Plano anual</p>
			<div class="area-preco">
			<p class="preco">R$ 199,99</p>
			<p class="preco-detalhe">/ao ano</p>	
			</div>
			<button type="button" class="botao">Assinar</button>
			</div>
			
		</div>
		</div>
	</section>
</main>
    
<footer>
</footer>

</body>
</html>
