function validateForm() {
    let nome = document.getElementById("nome").value.trim();
    let email = document.getElementById("email").value.trim();
    let telefone = document.getElementById("telefone").value.trim();
    let rua = document.getElementById("Rua").value.trim();
    let cep = document.getElementById("CEP").value.trim();

    // Limpa mensagens de erro anteriores
    limparErros();

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const telefoneRegex = /^\(?\d{2}\)?\s?\d{4,5}-?\d{4}$/;
    const cepRegex = /^\d{5}-?\d{3}$/;

    let valido = true;

    if (nome === "") {
        exibirErro("erroNome", "Por favor, preencha o nome.");
        valido = false;
    }

    if (!emailRegex.test(email)) {
        exibirErro("erroEmail", "Por favor, insira um email válido.");
        valido = false;
    }

    if (!telefoneRegex.test(telefone)) {
        exibirErro("erroTelefone", "Telefone inválido. Ex: (11) 91234-5678");
        valido = false;
    }

    if (rua === "") {
        exibirErro("erroRua", "Por favor, preencha a rua.");
        valido = false;
    }

    if (!cepRegex.test(cep)) {
        exibirErro("erroCep", "CEP inválido. Ex: 12345-678");
        valido = false;
    }

    return valido;
}

function exibirErro(idElemento, mensagem) {
    document.getElementById(idElemento).textContent = mensagem;
    document.getElementById(idElemento).style.color = "red";
}

function limparErros() {
    const erros = document.querySelectorAll(".error");
    erros.forEach(e => e.textContent = "");
}

function toggleEdit() {
    const campos = ["nome", "email", "telefone", "Rua", "CEP"];
    campos.forEach(id => {
        document.getElementById(id).readOnly = false;
    });

    document.getElementById("editButton").style.display = "none";
    document.getElementById("submitButton").style.display = "inline";
}
