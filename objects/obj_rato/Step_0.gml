// Olha para direção certa
olha_certo();

// Timer para trocar de direção
timer_direcao--;
if (timer_direcao <= 0)
{
    muda_direcao();
    timer_direcao = tempo_direcao;
}

// Checa se colidio com uma parede
var _col_parede = move_and_collide(velh * vel, velv * vel, colisao_lista, 24);
if (array_length(_col_parede))
{
    muda_direcao();
    timer_direcao = tempo_direcao;
}

depth = -y;

realiza_efeito_pulinho();