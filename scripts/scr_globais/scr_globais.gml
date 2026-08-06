// Lista de incredientes da loja
enum INGREDIENTE
{
    TOMATE,
    CEBOLA,
    QUEIJO,
    ALFACE,
    PICLES,
    PAO_BAIXO,
    PAO_CIMA,
    CARNE_CRUA,
    CARNE_ASSADA,
    CARNE_QUEIMADA,
    TOTAL
}

// Deixa o jogo aleatório
randomise();

// Create event
function inicia_efeito_pulinho(_vel_passo = 0.25, _forca_pulo = 0.15, _forca_giro = 4)
{
    // Variáveis do efeito de pulinho
    passo_timer = 0;
    vel_passo   = _vel_passo;
    forca_pulo  = _forca_pulo;
    forca_giro = _forca_giro;
}

// Step event
function realiza_efeito_pulinho()
{
    var _movendo = (x != xprevious || y != yprevious);
    
    if (_movendo)
    {
        // Incrementa o ciclo do passo
        passo_timer += vel_passo;
    }
    else
    {
        // Reseta suavemente para a posição em pé quando parar
        passo_timer = lerp(passo_timer, 0, 0.2);
    }
}

// Draw event
function desenha_efeito_pulinho()
{
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
}