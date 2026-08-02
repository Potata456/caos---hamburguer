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

#endregion