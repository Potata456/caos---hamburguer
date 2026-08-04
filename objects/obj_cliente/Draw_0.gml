draw_self();

var _qtd = array_length(pedido);

if (estado_atual != ESTADO_CLIENTE.SAINDO_FELIZ && estado_atual != ESTADO_CLIENTE.SAINDO_RAIVA &&  _qtd > 0)
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