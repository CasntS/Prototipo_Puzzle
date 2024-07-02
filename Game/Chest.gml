_CREATE EVENT_
#region Valores/Atributos do Baú
tranca = 15; // Fechadura do baú.
codigo = 0; // Sua chave atual. (Botões Ligados)
destrancado = false; // Atributo que diz se o baú está aberto ou fechado.
#endregion

_STEP EVENT_
#region Verificar Chave / Pegar a Chave
if (codigo != tranca) // Verifica se a chave é diferente da fechadura...
{					 // Se sim continua:
	codigo = 0; // Verifica o tanto de botões ligados
	codigo += a1.botaoligado + a2.botaoligado + a3.botaoligado; // <
	codigo += b1.botaoligado + b2.botaoligado + b3.botaoligado; // < Soma dos
	codigo += c1.botaoligado + c2.botaoligado + c3.botaoligado; // < botões
	codigo += d1.botaoligado + d2.botaoligado + d3.botaoligado; // < ligados.
	codigo += e1.botaoligado + e2.botaoligado + e3.botaoligado; // <
}
if (destrancado == false && codigo == tranca) // Verifica se o baú está trancado...
{  // e a chave é igual a fechadura.
	destrancado = true; // Destranca o baú.
	image_index = 1; // Muda o sprite do baú pra ele aberto.
}
if (distance_to_object(obj_player) < 10 && destrancado == true && keyboard_check(vk_space))
{ // ^ Se o baú está aberto E o jogador está perto dele E o jogador clica espaço:
	obj_player.chave_azul = 1; // O jogador pega a chave azul.
	image_index = 2; // Muda o sprite do baú pra ele vazio.
}
#endregion
