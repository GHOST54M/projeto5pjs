<html>

<head>
		<title>Sistema gerenciador de reservas de restaurante
		</title>
		
        <meta name="viewport" content="width=device-width, initial-scale=1">       
		<meta charset="UTF-8">
		
		<link rel="stylesheet" type="text/css" href="css/reset.css">
		
<style>
    body {
      font-family: Arial, sans-serif; 
      text-align: center;
      margin-top: 60px;
    }

    .container {
      display: inline-block;
      text-align: left;
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
    
    .formulario{
    width: 350px;
    }
    
    label {
      font-size: 26px;
      display: block;
      margin-top: 20px;
    }

    input[type="text"], input[type="password"] {
      width: 100%;
      padding: 10px;
      margin-top: 5px;
      border: 1px solid #771b1b;
      border-radius: 4px;
      box-shadow: 0 2px 4px rgba(119, 27, 27, 0.3);
      height:40px;
      font-size:24px;
    }

    .senha-container {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .esqueceu {
      font-size: 12px;
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
	<section>
		<div class="container">
		<% String mensagemErro = (String) request.getAttribute("mensagemErro"); %>
		<% if (mensagemErro != null) { %>
		    <div style="color: red;"><%= mensagemErro %></div>
		<% } %>
		
		 <a href="index.jsp"><button class="back-button">&#8592;</button></a>
		
		    <form action="loginRestaurante" method="post">
		      <label for="cnpj">CNPJ</label>
		      <input type="text" id="cnpj" name="cnpj" required>
		
		      <div class="senha-container">
		        <label for="senha">Senha</label>
		        <span class="esqueceu">Esqueceu a senha?</span>
		      </div>
		      <input type="password" id="senha" name="senha" required>
			
			<div class="cadastro">
		      <button type="submit" class="botao-entrar">Entrar</button>
		    </div>
		    </form>
		
		    <div class="cadastro">
		      <a href="cadastroRestaurante.jsp">Cadastrar Restaurante</a>
		    </div>
		  </div>
	</section>
	</main>

	<footer>
	</footer>
	
</body>

</html>