// Se estiver no estado de escorregar, desenha normal
if (estado_atual == estado_escorrega)
{
    draw_self();
}
else
{
    // Animação de caminhada
    var _escala_y = 1 + sin(passo_timer) * forca_pulo;
    var _escala_x = 1 - sin(passo_timer) * (forca_pulo * 0.5);
    var _angulo   = sin(passo_timer * 0.5) * forca_giro;

    draw_sprite_ext(
        sprite_index,
        image_index,
        x,
        y,
        _escala_x * image_xscale,
        _escala_y,
        image_angle + _angulo,
        image_blend,
        image_alpha
    );
}
var _qtd = array_length(pedido);

if (estado_atual != estado_sair_feliz && estado_atual != estado_sair_raiva && estado_atual != estado_sair_enjoado && _qtd > 0)
{
    var _espacamento = sprite_get_width(spr_ingrediente) + 2;
    var _largura_total = _qtd * _espacamento;
    var _start_x = x - (_largura_total / 2) + 4;
    var _pos_y = y - 15; // Desenha 40 pixels acima do cliente
    
    // Percorre a lista de ingredientes do pedido e desenha
    for (var i = 0; i < _qtd; i++)
    {
        var _ingrediente = pedido[i];
        
        draw_sprite(spr_ingrediente, _ingrediente, _start_x + (i * _espacamento), _pos_y);
    }
}

draw_circle(x, y, dis_max, 2);