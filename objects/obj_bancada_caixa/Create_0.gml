image_index = tipo_ingrediente;

#region Variáveis

muda_efeito = false;
tempo_efeito = game_get_speed(gamespeed_fps) - 30;
timer_efeito = tempo_efeito;

inicia_efeito_pulinho(0.10, 0.1, 2);
aplica_efeito_squash_stretch();

#endregion