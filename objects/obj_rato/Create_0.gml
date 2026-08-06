#region Variáveis

// Variáveis de controle do movimento
vel = 0.3;
velh = 0;
velv = 0;

// Tempo para mudar de direção
tempo_direcao = game_get_speed(gamespeed_fps) * 3;
timer_direcao = 60;

colisao_lista = [obj_colisao, obj_colisao_2];

inicia_efeito_pulinho();

#endregion


// Método para mudar de direção
muda_direcao = function()
{
    // Escolhe uma direção aleatória
    velh = choose(-1, 1);
    velv = choose(-1, 1);
}

// Método para olhar para o lado certo
olha_certo = function()
{
    if (velh != 0)
    {
        image_xscale = sign(velh);
    }
}