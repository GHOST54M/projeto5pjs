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
		<form class="formulario" action="cadastroRestaurante2.jsp" method="POST">
		    <label for="nome">Digite seu nome do restaurante:</label>
		    <input type="text" id="nome" name="nome" required>
		
		    <label for="email">Digite seu email:</label>
		    <input type="text" id="email" name="email" required>
		    
		    <label for="cnpj">Digite seu CNPJ:</label>
		    <input type="text" id="cnpj" name="cnpj" required>
		    		
		    <label for="Municipio">Município:</label>
		    <input type="text" id="Municipio" name="Municipio" required placeholder="Digite apenas números!">
		
		    <label for="UF">UF:</label>
		    <input type="text" id="UF" name="UF" required>
		
		    <label for="Rua">Rua</label>
		    <input type="text" id="Rua" name="Rua" required>
		    
		    <label for="numero">Número</label>
		    <input type="text" id="numero" name="numero" required>
		    
		    <label for="cep">CEP:</label>
		    <input type="text" id="cep" name="cep" required>
		    
		    <label for="Senha">Senha</label>
		    <input type="password" id="Senha" name="Senha" required>
		    
		    <label for="confirmarsenha">Confirmar Senha:</label>
		    <input type="password" id="confirmarsenha" name="confirmarsenha" required>
		    		    		
		    <input type="submit" value="Continuar cadastro">
		    
		    <script src="javascript/validarCadastroRestaurante.js" defer></script>
		  
		</form>
		<a href="login_restaurante.jsp">Voltar</a>
</section>
</main>

<footer>
</footer>

</body>
</html>