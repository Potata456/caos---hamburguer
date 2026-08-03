draw_self();

// Pega a quantidade de ingredientes na lista
var _qtd = array_length(ingredientes_prato);
var _offset_y = 0; // Quantos pixels subir a cada camada

// Pega a altura real do sprite de ingredientes
var _altura_sprite = sprite_get_height(spr_ingrediente);

for (var i = 0; i < _qtd; i++)
{
    var _ingrediente = ingredientes_prato[i];
    
    // Desenha o ingrediente
    draw_sprite(spr_ingrediente, _ingrediente, x - 0.5, y - 2 - _offset_y);
    
    // Aumenta a altura para o próximo ingrediente ficar um pouco mais para cima
    _offset_y += _altura_sprite - 1.5; // Ajuste este valor
}