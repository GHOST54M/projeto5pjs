document.addEventListener("DOMContentLoaded", function () {
  const form = document.querySelector(".formulario");

  form.addEventListener("submit", function (event) {
    let erros = [];

    const email = document.getElementById("email").value.trim();
    const cnpj = document.getElementById("cnpj").value.trim();
    const municipio = document.getElementById("Municipio").value.trim();
    const uf = document.getElementById("UF").value.trim();
    const rua = document.getElementById("Rua").value.trim();
    const numero = document.getElementById("numero").value.trim();
    const cep = document.getElementById("cep").value.trim();
    const senha = document.getElementById("Senha").value;
    const confirmarSenha = document.getElementById("confirmarsenha").value;

    // Email
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      erros.push("Email inválido.");
    }

    // CNPJ
    if (!/^\d{14}$/.test(cnpj)) {
      erros.push("CNPJ deve conter exatamente 14 números.");
    }

    // Município
    if (!/^[A-Za-zÀ-ÿ\s]+$/.test(municipio)) {
      erros.push("Município deve conter apenas letras.");
    }

    // UF
    if (!/^[A-Za-z]{2}$/.test(uf)) {
      erros.push("UF deve conter exatamente 2 letras.");
    }

    // Rua
    if (rua.length === 0) {
      erros.push("Rua não pode estar vazia.");
    }

    // Número
    if (!/^\d+$/.test(numero)) {
      erros.push("Número deve conter apenas dígitos.");
    }

    // CEP
    if (!/^(\d{5}-\d{3}|\d{8})$/.test(cep)) {
      erros.push("CEP deve estar no formato 00000-000 ou conter 8 dígitos.");
    }

    // Senhas
    if (senha.length < 6) {
      erros.push("A senha deve ter pelo menos 6 caracteres.");
    }
    if (senha !== confirmarSenha) {
      erros.push("As senhas não coincidem.");
    }

    // Exibir erros
    if (erros.length > 0) {
      alert(erros.join("\n"));
      event.preventDefault(); // Impede o envio do formulário
    }
  });
});
