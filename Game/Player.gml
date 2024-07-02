_CREATE EVENT_ !Under Development!
#region !!!MUDAR ISSO PARA O MENU PRINCIPAL!!!
window_set_size(1280,720);
window_center();
window_set_cursor(cr_none);
cursor_sprite = spr_cursor;
#endregion

#region Valores/Atributos

move_spd = 2;//Definir a velocidade do personagem
x_spd = 0;
y_spd = 0;
x_y_spd = 0;

cooldownfantasma = 0; // Cooldown do modo fantasma
fantasma = 0; // Modo Fantasma
#endregion

#region Chaves
chave_azul = 0;
chave_verde = 0;
chave_vermelha = 0;
#endregion

_STEP EVENT_ !Under Development!
#region Controles
// atribuição as teclas de movimento e troca de lado do sprite
up_key = keyboard_check(ord("W"));
down_key = keyboard_check(ord("S"));
left_key = keyboard_check(ord("A"));
right_key = keyboard_check(ord("D"));

x_spd = (right_key - left_key) * move_spd;
y_spd = (down_key - up_key) * move_spd;
x_y_spd = x_spd + y_spd;

if (place_meeting(x + x_spd, y, obj_wall))
{
	if (place_meeting(x + x_spd, y-3, obj_wall))
	{
		y += 1;
		x_spd = x_spd/4;
	}
	if (place_meeting(x + x_spd, y+3, obj_wall))
	{
		y -= 1;
		x_spd = x_spd/4;
	}
	if (!place_meeting(x + x_spd, y-3, obj_wall))
	{
		x_spd = 0;
	}
	if (!place_meeting(x + x_spd, y+3, obj_wall))
	{
		x_spd = 0;
	}
}
if (place_meeting(x, y + y_spd, obj_wall))
{
	if (place_meeting(x-3, y + y_spd, obj_wall))
	{
		x += 1;
		y_spd = y_spd/4;
	}
	if (place_meeting(x+3, y + y_spd, obj_wall))
	{
		x -= 1;
		y_spd = y_spd/4;
	}
	if (!place_meeting(x-3, y + y_spd, obj_wall))
	{
		y_spd = 0;
	}
	if (!place_meeting(x+3, y + y_spd, obj_wall))
	{
		y_spd = 0;
	}
}

x += x_spd;
y += y_spd;


if (keyboard_check(ord("F")) && cooldownfantasma == 0)
{	// ^ Se o player clicar a tecla "F" E o cooldown fantasma == 0, continua:
	if (fantasma == 0) // Verifica se o Modo Fantasma está desligado.
	{					
		fantasma += 1; // Liga o Modo Fantasma (Troca a colisão dos objetos atravessaveis).
		cooldownfantasma += 20; // Aumenta o cooldown fantasma.
		sprite_index = spr_fantasma_form; // Troca apenas o sprite do player...
		mask_index = spr_player; // mas a colisão continua a mesma (Para não atravessar tudo).
	}
	else // Verifica se o Modo Fantasma está ligado.
	{
		fantasma -= 1;  // Desliga o Modo Fantasma.
		cooldownfantasma += 20; // Aumenta o cooldown fantasma.
		sprite_index = spr_player; // Troca o sprite do player.
	}
}
#endregion
#region !!!MUDAR ISSO PARA O MENU PRINCIPAL!!!
if (mouse_button = mb_left) // Se o player clicar com o botão esquerdo do mouse:
{
    cursor_sprite = spr_cursor_click; // Troca o sprite do mouse.
}
else // Se ele não clicar:
{
	cursor_sprite = spr_cursor; // Volta ao sprite normal do mouse.
}
#endregion
#region Cooldown Fantasma Tick
if (cooldownfantasma > 0) // Se o cooldown fantasma for maior que 0:
{
	cooldownfantasma -= 1; // Diminui o cooldown.
}
#endregion
