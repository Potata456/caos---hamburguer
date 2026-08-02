#region Variáveis

// Variáveis de velocidadede do player
vel     = 1;
velh    = 0;
velv    = 0;

// Inputs do player
left    = false;
right   = false;
top     = false;
down    = false;
interagir = false;

// Máquina de estados
estado_atual = noone;

#endregion

#region Métodos

// Movimento e Colisão do player  ===========================

// Método para pegar os inputs do player
pega_inputs = function()
{
    left    = keyboard_check(ord("A"));
    right   = keyboard_check(ord("D"));
    top     = keyboard_check(ord("W"));
    down    = keyboard_check(ord("S"));
    interagir = keyboard_check_pressed(ord("E"));
}

// Método para aplicar o movimento
aplica_movimento = function()
{
    // Aplica velocidade na horizontal
    velh = (right - left) * vel;
    
    // Aplica velocidade na vertical
    velv = (down - top) * vel;
}

// Método para colidir e se mover
colisao = function()
{
    // Colide na horizontal
    move_and_collide(velh, 0, obj_colisao, 24);
    
    // Colide na vertical
    move_and_collide(0, velv, obj_colisao, 24);
    
}

// Método para fazer o player olhar o lado certo
olha_certo = function()
{
    if (velh != 0)
    {
        image_xscale = sign(velh);
    }
}
// ==========================================================
// Método para checar se está perto de objeto que da para interagir
proximo_interagir = function()
{
    if (!instance_exists(obj_caixa)) return;
        
    var _dis = point_distance(x, y, obj_caixa.x, obj_caixa.y)
    
    if (_dis < 20)
    {
        if (interagir)
        {
            instance_create_layer(x, y, "ingredientes", obj_carne);
        }
    }
    else
    {
        
    }
}

// ==========================================================
// Método se o player estiver parado
estado_parado = function()
{
    velh = 0;
    velv = 0;
    
    // Troca para o estado de movendo
    if (left xor right || top xor down) estado_atual = estado_movendo;
}

// Método se o player estiver se movendo
estado_movendo = function()
{
    aplica_movimento();
    
    // Troca para o estada de parado
    if (velh == 0 && velv == 0) estado_atual = estado_parado;
}

// Começa no estado parado
estado_atual = estado_parado;
// ==========================================================
#endregion