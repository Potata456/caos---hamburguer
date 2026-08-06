estado_atual();

depth = -y;

// Detecta movimento do cliente
var _movendo = (x != xprevious || y != yprevious);

// Não faz o pulinho normal se estiver escorregando no chão
if (_movendo && estado_atual != estado_escorrega)
{
    passo_timer += vel_passo;
}
else
{
    passo_timer = lerp(passo_timer, 0, 0.2);
}