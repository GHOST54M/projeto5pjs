<!DOCTYPE html>
<html>
<head>

        <meta name="viewport" content="width=device-width, initial-scale=1">       
		<meta charset="UTF-8">
		
		<link rel="stylesheet" type="text/css" href="css/reset.css">
	
		<title>Cadastro VENano</title>
		<style>
    body {
    	font-family: Arial, sans-serif;
      text-align: center;
      margin-top: 60px;
    }

    .conteudo {
      display: inline-block;
      text-align: left;
      margin-bottom: 60px;
      width:400px;
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
        label {
      font-size: 26px;
      display: block;
      margin-top: 20px;
    }
        input[type="text"], input[type="password"],input[type="number"] {
      width: 100%;
      padding: 10px;
      margin-top: 5px;
      border: 1px solid #771b1b;
      border-radius: 4px;
      box-shadow: 0 2px 4px rgba(119, 27, 27, 0.3);
      height:18px;
      font-size:24px;
	}

    .senha-container {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    
        .botao-entrar {
      background-color: #771b1b;
      color: white;
      padding: 10px 20px;
      border: none;
      margin-top: 20px;
      cursor: pointer;
    }

    .botao-entrar:hover {
      background-color: #5e1515;
    }
    
        .cadastro {
      text-align: center;
      margin-top: 10px;
      font-size: 14px;
    }
		</style>
</head>
<body>

<header>
</header>

<main>	
<section class="conteudo">
				<% String erro = (String) request.getAttribute("mensagemErro"); %>
				<% if (erro != null) { %>
				    <div style="color:red;"><%= erro %></div>
				<% } %>

        			<a href="login_restaurante.jsp"><button class="back-button">&#8592;</button></a>
    
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
		    	
		    <div class="cadastro">   		
		    <input type="submit" value="Continuar cadastro" class="botao-entrar">
		    </div>
		    <script src="javascript/validarCadastroRestaurante.js" defer></script>
		  
		</form>
</section>
</main>

<footer>
</footer>

</body>
</html>