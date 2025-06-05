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
	
    <title>Perfil do Cliente</title>
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

		.dadosusuario{	
			display: inline-block;
      		text-align: left;
    	}	
    	
    	.area_dados_usuario{
	    	display: flex;
	    	justify-content: center;
	    	margin-top:20px;   	
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
            border: 2px solid #ccc;
            border-radius: 10px;
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
        
    </style>
</head>
<body>
<header>
	<div class="cabecalho">
		<a href="perfilUsuario.jsp"><img src="imagens/perfil.png"  class="cabecalhoimagem"></a>
		<a href=""><img src="imagens/configuracoes.png"  class="cabecalhoimagem"></a>
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
		        <p>Dados do Usuário</p>
		
		        <button type="button" id="editButton" onclick="toggleEdit()">Editar</button>
		        <button type="submit" id="submitButton" style="display: none;">Salvar Alterações</button>
		
		        <input type="hidden" id="id" name="id" value="<%= Cliente.getId() %>"><br>
		
		        <label for="nome" class="nome">Nome:</label><br>
		        <input type="text" id="nome" name="nome" value="<%= Cliente.getNome() %>" readonly><br>
		
		        <label for="email" class="email">Email:</label><br>
		        <input type="text" id="email" name="email" value="<%= Cliente.getEmail() %>" readonly><br>
		
		        <div>
		            <label for="telefone">Telefone:</label><br>
		            <input type="text" id="telefone" name="telefone" value="<%= Cliente.getTelefone() %>" readonly><br>
		  
				</div>
		</form>
		</div>
	</section>
</main>
    
<footer>
</footer>

</body>
</html>
