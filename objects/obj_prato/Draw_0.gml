// Calcula o efeito de esticar/achatar
var _escala_y = 1 + sin(passo_timer) * forca_pulo;
var _escala_x = 1 - sin(passo_timer) * (forca_pulo * 0.5);

// Calcula o gira/inclinação para os lados
var _angulo = sin(passo_timer * 0.5) * forca_giro;

// Desenha a sprite com as transformações aplicadas
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

// Pega a quantidade de ingredientes na lista
var _qtd = array_length(ingredientes_prato);
var _offset_y = 0; // Quantos pixels subir a cada camada

// Pega a altura real do sprite de ingredientes
var _altura_sprite = sprite_get_height(spr_ingrediente);

for (var i = 0; i < _qtd; i++)
{
    var _ingrediente = ingredientes_prato[i];
    
    // Desenha o ingrediente
    draw_sprite_ext(
        spr_ingrediente,
        _ingrediente,
        x,
        y + 1 - _offset_y,
        _escala_x,
        _escala_y,
        image_angle + _angulo,
        image_blend,
        image_alpha
    );
    
    _offset_y += _altura_sprite - 5;
}