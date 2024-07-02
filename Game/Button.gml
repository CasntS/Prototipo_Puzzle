_CREATE EVENT_
#region Valores/Atributos do botão
cooldownbotao = 0; /* Cooldown do botão, pra não piscar enquanto o player
				      fica em cima do botão. */
clicado = false; /* Verifica se o player está em cima do botão.
				    !Importante por conta da REAÇÃO EM CADEIA! */
#endregion
#region Função: Reação em Cadeia
function ativar_vizinho() // Função para ver se existe... (Reação em Cadeia)
{						  // botões próximos do botão ativado.
	verificar_pos = [[32,0],[-32,0],[0,32],[0,-32]]; /* Define o local onde o botão...
													    pode estar. */
	for (i = 0; i < array_length(verificar_pos); i++) // Troca o lugar que deve procurar.
	{												  // Ordem: X-> -X -> Y -> -Y
		var _id = instance_place(x+verificar_pos[i,0],y+verificar_pos[i,1],obj_botao);
		/* ^Guarda o ID do botão achado em uma variável temporária;
		   ^Se não achar nada: _id = noone. */
		if (_id != noone) // Verifica se realmente achou um botão próximo.
		{
			switch (_id.botaoligado) // Detecta o valor de botaoligado...
			{                        // do botão achado.
				case 1: // Se: (botaoligado = 1) == (botão está ligado), ele desliga.
					_id.image_index = 0;
					_id.botaoligado = 0;
				break;
				case 0: // Se: (botaoligado = 0) == (botão está desligado), ele liga.
					_id.image_index = 1;
					_id.botaoligado = 1;
				break;
			}	
		}
	}
}
#endregion

_STEP EVENT_
#region Cooldown Botão Tick
if (!place_meeting(x, y, obj_player) && cooldownbotao > 0 && clicado = true)
{ // Código para abaixar o cooldown do botão quando o player não tá em cima.
	cooldownbotao -= 1; // Abaixa o cooldown do botão
	clicado = false; // Desliga o estado do player estar no botão
}
#endregion
#region Liga/Desliga o Botão + Ativa a reação em cadeia
if (clicado == true) // Inicia o processo se o player estiver no botão.
{
	if (cooldownbotao == 0) // Verifica se o botão não tá em cooldown.
	{
		cooldownbotao += 1; // Aumenta o cooldown do botão.
		ativar_vizinho() // Inicia a função: Reação em Cadeia
		switch (botaoligado) // Ve se o botão está ligado ou desligado
		{
			case 1: // Se for = 1 == (Ligado), ele desliga...
				image_index = 0; // e troca o sprite do botão.
				botaoligado = 0;
			break;
			case 0: // Se for = 0 (Desligado), ele liga...
				image_index = 1; // e troca o sprite do botão.
				botaoligado = 1;
			break;
		}
	}
}
#endregion
#region Modo Fantasma: oBotão
if (obj_player.fantasma == 1) // Verifica se o Modo Fantasma está ativo...
{ // e se sim, continua:
	mask_index = spr_fantasma_form; // Troca a colisão do botão para nenhuma.
	sprite_index = spr_botao; // Mantém o sprite.
}
else // Se o Modo Fantasma estiver desativado:
{
	mask_index = spr_botao; // Troca a colisão do botão para a padrão.
	sprite_index = spr_botao;
}
#endregion

_COLLISION EVENT - Player_
#region Verificar Baú
if (obj_bau.destrancado == true) // Se o baú já está aberto:
{
	exit; // O programa não lê o resto deste código.
}
else // Se o baú não está aberto:
{
	clicado = true; // Liga o botão.
}
#endregion
