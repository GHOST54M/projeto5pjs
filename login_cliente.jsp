<html>

<head>
		<title>Sistema gerenciador de reservas de restaurante
		</title>
		
        <meta name="viewport" content="width=device-width, initial-scale=1">       
		<meta charset="UTF-8">
		
		<link rel="stylesheet" type="text/css" href="css/reset.css">
		
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
			<form class="formulario" action="loginCliente" method="POST">
			
			    <label for="email">Digite seu email:</label>
			    <input type="text" id="email" name="email" required>
			
			    <label for="senha">Digite sua senha:</label>
			    <input type="password" id="senha" name="senha" required>
			
			    <input type="submit" value="Entrar">
				<a href="cadastroCliente.jsp">Cadastrar-se</a>			    
			</form>
		</section>
		<a href="index.jsp">Voltar</a>
		
	</main>

	<footer>
	</footer>
	
</body>

</html>