document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector(".formulario");

    form.addEventListener("submit", function (event) {
        let mensagensErro = [];

        // Captura os valores
        const nome = document.getElementById("nome").value.trim();
        const email = document.getElementById("email").value.trim();
        const celular = document.getElementById("celular").value.trim();
        const rua = document.getElementById("rua").value.trim();
        const cep = document.getElementById("cep").value.trim();
        const senha = document.getElementById("senha").value;
        const senhaConfirmar = document.getElementById("senhaconfirmar").value;

        // Validações
        if (nome.length < 3) mensagensErro.push("Nome deve ter pelo menos 3 caracteres.");

        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) mensagensErro.push("Email inválido.");

        if (celular.length < 8) mensagensErro.push("Celular deve ter pelo menos 8 dígitos.");

        if (rua.length < 3) mensagensErro.push("Rua deve ter pelo menos 3 caracteres.");

        if (cep.length < 8) mensagensErro.push("CEP deve ter 8 dígitos.");

        if (senha.length < 6) mensagensErro.push("Senha deve ter no mínimo 6 caracteres.");

        if (senha !== senhaConfirmar) mensagensErro.push("As senhas não coincidem.");

        // Exibe os erros, se houver
        const erroContainer = document.getElementById("erros-validacao");
        if (!erroContainer) {
            const div = document.createElement("div");
            div.id = "erros-validacao";
            div.style.color = "red";
            form.appendChild(div);
        }

        document.getElementById("erros-validacao").innerHTML = mensagensErro.map(m => `<p>${m}</p>`).join("");

        if (mensagensErro.length > 0) {
            event.preventDefault(); // impede o envio do formulário
        }
    });
});
