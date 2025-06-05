<!DOCTYPE html>
<html>
<head>

        <meta name="viewport" content="width=device-width, initial-scale=1">       
		<meta charset="UTF-8">
		
		<link rel="stylesheet" type="text/css" href="css/reset.css">
	
		<title>Cadastro VENano</title>
		<style>
		
		.formulario, .conteudo{
		    display: flex;
    		flex-direction: column;
    		align-items: center;
		}
		</style>
</head>
<body>

<header>
</header>

<main>	
<section class="conteudo">
    <!-- Verifica se existe uma mensagem de erro -->
    <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
    %>
        <div style="color: red;">
            <%= errorMessage %> <!-- Exibe a mensagem de erro -->
        </div>
    <%
        }
    %>
		<form class="formulario" action="cadastroCliente" method="POST">
		    <label for="nome">Digite seu nome:</label>
		    <input type="text" id="nome" name="nome" required>
		
		    <label for="email">Digite seu email:</label>
		    <input type="text" id="email" name="email" required>
		
		    <label for="celular">Digite seu celular:</label>
		    <input type="number" id="celular" name="telefone" required placeholder="Digite apenas números!">
		
		    <label for="senha">Digite sua senha:</label>
		    <input type="password" id="senha" name="senha" required>
		
		    <label for="senhaconfirmar">Confirme sua senha:</label>
		    <input type="password" id="senhaconfirmar" name="senhaconfirmar" required>
		
		    <input type="submit" value="Cadastrar">
		    
		    <script src="validarCadastroUsuario.js"></script>
		</form>
		<a href="login_cliente.jsp">Voltar</a>
</section>
</main>

<footer>
</footer>

</body>
</html>