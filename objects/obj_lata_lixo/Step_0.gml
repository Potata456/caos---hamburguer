checa_itens();

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