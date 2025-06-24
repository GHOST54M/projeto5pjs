<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />

  <title>Mesa Já</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: Arial, sans-serif;
      background-color: #ffffff;
      color: #333;
    }

    header {
      background-color: #7a1c1c;
      color: white;
      text-align: center;
      padding: 20px;
      font-size: 2rem;
    }

    .container {
      padding: 40px 60px;
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      flex-wrap: wrap;
    }

    .left, .right {
      flex: 1 1 45%;
      min-width: 300px;
      margin-bottom: 40px;
    }
    
    .right-botao{
    display: flex;
    justify-content: flex-end;
    }

    h2 {
      font-size: 1rem;
      font-weight: bold;
      margin-bottom: 10px;
    }

    p {
      margin-bottom: 10px;
      line-height: 1.6;
    }

    .highlight {
      font-weight: bold;
    }

    .premium {
      font-weight: bold;
    }

    .button {
      display: inline-block;
      background-color: #7a1c1c;
      color: white;
      padding: 12px 24px;
      text-decoration: none;
      border-radius: 4px;
      font-size: 1rem;
      margin-top: 20px;
    }

    .bottom-bar {
      border-top: 2px solid #ccc;
    }

    .bottom-buttons {
      padding: 40px 60px;
      display: flex;
      justify-content: space-between;
      flex-wrap: wrap;
    }

    .bottom-buttons a {
      background-color: #7a1c1c;
      color: white;
      padding: 16px 30px;
      text-decoration: none;
      font-size: 1.1rem;
      border-radius: 4px;
      margin-top: 10px;
    }

    @media (max-width: 768px) {
      .container, .bottom-buttons {
        flex-direction: column;
        padding: 20px;
      }

      .left, .right {
        flex: 1 1 100%;
      }

      .bottom-buttons a {
        width: 100%;
        text-align: center;
      }
    }
  </style>
</head>
<body>

  <header>Mesa Já</header>

  <div class="container">
    <div class="left">
      <h2>Reserve sua mesa com praticidade e chegue com tudo pronto!</h2>
      <p>Encontre restaurantes, faça sua reserva com antecedência.</p>
      <p>No plano <span class="premium">premium</span>, antecipe também seu pedido: seu prato estará pronto quando você chegar! Mais agilidade, conforto e uma experiência gastronômica completa esperando por você.</p>
    </div>
    <div class="right right-botao">
      <a href="login_cliente.jsp" class="button">Área do cliente</a>
    </div>
  </div>

  <div class="bottom-bar"></div>
  

  
  <div class="container">
    <div class="left">
     <a href="login_restaurante.jsp" class="button">Área do Restaurante</a>
  </div>
  
    <div class="right">
      <h2>Otimize sua operação e encante seus clientes!</h2>
      <p>Com nosso sistema de reservas, seu restaurante gerencia mesas, horários e recebe clientes pontualmente, graças à integração com apps como Uber e 99.</p>
      <p>Permita que seus clientes façam pedidos antecipados e tenha os pratos prontos na chegada, reduzindo o tempo de mesa ociosa e aumentando sua capacidade de atendimento.</p>
      <p>Eficiência para você, experiência impecável para eles.</p>
    </div>
  </div>



</body>
</html>
