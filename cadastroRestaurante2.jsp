<!DOCTYPE html>
<%
    String nome = request.getParameter("nome");
    String email = request.getParameter("email");
    String cnpj = request.getParameter("cnpj");
    String municipio = request.getParameter("Municipio");
    String uf = request.getParameter("UF");
    String rua = request.getParameter("Rua");
    String numero = request.getParameter("numero");
    String cep = request.getParameter("cep");
    String senha = request.getParameter("Senha");
    // Armazenar na sess�o
    session.setAttribute("nome", nome);
    session.setAttribute("email", email);
    session.setAttribute("cnpj", cnpj);
    session.setAttribute("municipio", municipio);
    session.setAttribute("uf", uf);
    session.setAttribute("rua", rua);
    session.setAttribute("numero", numero);
    session.setAttribute("cep", cep);
    session.setAttribute("senha", senha);
%>

<html>
<head>

        <meta name="viewport" content="width=device-width, initial-scale=1">       
		<meta charset="UTF-8">
		
		<link rel="stylesheet" type="text/css" href="css/reset.css">
	
		<title>Cadastro VENano</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container{
        margin-top:20px;
        }
        .form-container {
            width: 500px;
            margin: auto;
        }
        .section-title {
		font-size:24px;
		margin-bottom: 20px;
		
        }
        input[type="text"],
        input[type="file"],
        input[type="number"],
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
        .checkbox-group {
            background-color: #7b1c1c;
            color: white;
            padding: 10px;
        }
        .checkbox-group label {
            display: block;
            margin-bottom: 5px;
        }
        .inline {
            display: inline-block;
            width: 48%;
        }
        .submit-btn {
            background-color: #7b1c1c;
            color: white;
            padding: 10px;
            border: none;
            width: 100%;
            cursor: pointer;
            margin-top: 15px;
        }
        
        .horarios_funcionamento{
 			display: flex;
    		flex-wrap: wrap;   
    		justify-content: space-between;    
        }
        
        .horarios_funcionamento > .horario > input{
			width: 100px;
        }
        
        .horario{
		    display: flex;
		    flex-direction: column;
		}
    </style>
</head>
<body>

<header>
</header>

<main>	
	<section class="conteudo">
		<div class="form-container">
		    <form action="cadastroRestaurante" method="post" enctype="multipart/form-data">
		        
		        <section class="container">
			        <h2 class="section-title">Upload foto</h2>
			        <input type="file" name="foto" accept="image/*">
		        </section>
		        
		        <section class="container">
			        <div class="inline">
			            <h2>Telefone 1</h2>
			            <input type="text" name="telefone1">
			        </div>
			        <div class="inline" style="float: right;">
			            <h2>Telefone 2</h2>
			            <input type="text" name="telefone2">
			        </div>
				</section>
				
		        <div style="clear: both;"></div>
		 		
		 		<section class="container">	
			        <h2 class="section-title">Escolha as especialidades</h2>
				        <div class="checkbox-group">
				            <label><input type="checkbox" name="especialidades" value="Brasileira"> Culin�ria Brasileira</label>
				            <label><input type="checkbox" name="especialidades" value="Italiana"> Culin�ria Italiana</label>
				            <label><input type="checkbox" name="especialidades" value="Francesa"> Culin�ria Francesa</label>
				            <label><input type="checkbox" name="especialidades" value="Japonesa"> Culin�ria Japonesa</label>
				            <label><input type="checkbox" name="especialidades" value="�rabe"> Culin�ria �rabe</label>
				            <label><input type="checkbox" name="especialidades" value="Nordestina"> Culin�ria Nordestina</label>
				        </div>
			    </section>
			        
		 		<section class="container">				
			        <h2>Descri��o:</h2>
			        <textarea name="descricao"></textarea>
				</section>
				
				 <section class="container">
			        <h2 class="section-title">Defini��o de hor�rios de funcionamento</h2>
			        
					<div class="horarios_funcionamento">
					
					<div class="horario">
				        <label>Dias da semana</label>
				        <input type="time" name="semana_abre" placeholder="Abre">
				        <input type="time" name="semana_fecha" placeholder="Fecha">
					</div>
					
					<div class="horario">
				        <label>Feriados</label>
				        <input type="time" name="feriado_abre" placeholder="Abre">
				        <input type="time" name="feriado_fecha" placeholder="Fecha">
					</div>
					
					<div class="horario">
				        <label>Finais de semana</label>
				        <input type="time" name="fds_abre" placeholder="Abre">
				        <input type="time" name="fds_fecha" placeholder="Fecha">
				  
				    </div>
				    
					</div>
					
			        <label>Capacidade m�xima</label>
			        <input type="number" name="capacidade">
			
			        <label>M�x de pessoas por reserva</label>
			        <input type="number" name="max_reserva">
				</section>
				
		        <button type="submit" class="submit-btn">Finalizar cadastro</button>
		    </form>
		</div>
	</section>
</main>

<footer>
</footer>

</body>
</html>