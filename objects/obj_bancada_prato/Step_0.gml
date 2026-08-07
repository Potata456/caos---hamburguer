retorna_efeito_squash_stretch();

if (!muda_efeito)
{
    // Detecta movimento do cliente
    var _movendo = (x != xprevious || y != yprevious);
    
    // Não faz o pulinho normal se estiver escorregando no chão
    if (!_movendo)
    {
        passo_timer += vel_passo;
    }
    else
    {
        passo_timer = lerp(passo_timer, 0, 0.2);
    }
}

// Reseta efeito
if (muda_efeito)
{
    timer_efeito--;
    if (timer_efeito <= 0)
    {
        muda_efeito = false;
        timer_efeito = tempo_efeito;
    }
}