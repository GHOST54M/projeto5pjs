document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form");
    const erroContainer = document.getElementById("mensagens-erro");

    form.addEventListener("submit", function (event) {
        let mensagensErro = [];
        erroContainer.innerHTML = ""; // Limpa mensagens anteriores

        // Foto (se houver)
        const foto = form.querySelector("input[name='foto']");
        if (foto.files.length > 0) {
            const tipo = foto.files[0].type;
            if (!tipo.startsWith("image/")) {
                mensagensErro.push("O arquivo enviado deve ser uma imagem (JPG, PNG, etc).");
            }
        }

        // Telefones
        const telefone1 = form.querySelector("input[name='telefone1']").value.trim();
        const telefone2 = form.querySelector("input[name='telefone2']").value.trim();
        if (telefone1 === "" && telefone2 === "") {
            mensagensErro.push("Informe pelo menos um telefone.");
        }

        // Especialidades
        const especialidades = form.querySelectorAll("input[name='especialidades']:checked");
        if (especialidades.length === 0) {
            mensagensErro.push("Selecione ao menos uma especialidade.");
        }

        // Descrição
        const descricao = form.querySelector("textarea[name='descricao']").value.trim();
        if (descricao === "") {
            mensagensErro.push("Digite uma descrição do restaurante.");
        }

        // Horários
        const horarios = [
            "semana_abre", "semana_fecha",
            "feriado_abre", "feriado_fecha",
            "fds_abre", "fds_fecha"
        ];

		// Validação de horários (formato HH:mm)
		const regexHorario = /^([01]\d|2[0-3]):([0-5]\d)$/;
		
		const nomesLegiveis = {
		    semana_abre: "Semana (abre)",
		    semana_fecha: "Semana (fecha)",
		    feriado_abre: "Feriado (abre)",
		    feriado_fecha: "Feriado (fecha)",
		    fds_abre: "Final de semana (abre)",
		    fds_fecha: "Final de semana (fecha)"
		};
		
		let horariosInvalidos = [];
		
		for (let nome of horarios) {
		    const input = form.querySelector(`input[name='${nome}']`);
		    const valor = input.value;
		
		    if (valor === "" || !regexHorario.test(valor)) {
		        horariosInvalidos.push(nomesLegiveis[nome]);
		    }
		}
		
		if (horariosInvalidos.length > 0) {
		    mensagensErro.push(
		        "Preencha corretamente os horários no formato HH:mm para: " +
		        horariosInvalidos.join(", ") + "."
		    );
		}

        // Capacidade máxima
        const capacidade = form.querySelector("input[name='capacidade']").value;
        if (capacidade === "" || parseInt(capacidade) <= 0) {
            mensagensErro.push("Informe uma capacidade máxima válida.");
        }

        // Máximo por reserva
        const maxReserva = form.querySelector("input[name='max_reserva']").value;
        if (maxReserva === "" || parseInt(maxReserva) <= 0) {
            mensagensErro.push("Informe o número máximo de pessoas por reserva.");
        }

        // Exibir erros e impedir envio
        if (mensagensErro.length > 0) {
            event.preventDefault();
            erroContainer.innerHTML = "<ul><li>" + mensagensErro.join("</li><li>") + "</li></ul>";
        }
    });
});
