let senhaCorreta = "1234"; // Senha correta do usuário
let tentativas = 0; // Contador de tentativas de senha incorretas

// Função para bloquear o cartão do usuário após 3 tentativas de senha incorretas
function bloquearCartao() {
    console.log("Senha incorreta. Seu cartão foi bloqueado.");
    let opcao = prompt("Se deseja ir a uma agência, digite 'A'. Se deseja desbloquear com sua chave de segurança, digite 'D':");
    
    if (opcao === 'A') {
        console.log("Será um prazer atendê-la em uma agência.");
    } else if (opcao === 'D') {
        let chaveSeguranca = prompt("Digite a chave de segurança que foi enviada para seu e-mail cadastrado:");
        if (chaveSeguranca === "9999") {
            console.log("Digite uma nova senha para redefinição.");
        } else {
            console.log("Chave incorreta. Por favor, vá até uma agência.");
        }
    }
}

// Simulação de tentativas de login com senha incorreta
while (tentativas < 3) {
    let senha = prompt("Digite sua senha:");
    if (senha !== senhaCorreta) {
        tentativas++;
        console.log("Senha incorreta. Tentativa " + tentativas + "/3.");
    } else {
        console.log("Login bem-sucedido.");
        break;
    }
}

// Se o usuário esgotou todas as tentativas de senha incorretas
if (tentativas === 3) {
    bloquearCartao();
}
