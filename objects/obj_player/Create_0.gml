#region Variáveis

// Variáveis de velocidadede do player
vel     = 1;
velh    = 0;
velv    = 0;

// Inputs do player
left        = false;
right       = false;
top         = false;
down        = false;
interagir   = false;
soltar      = false;

// Máquina de estados
estado_atual = noone;

// Variáveu para saber se o player está com um item na mão
meu_item = noone;

// Distanca máxima de coleta de itens e interação com os objetos
dis_max = 20;

colisao_lista = [obj_colisao, obj_colisao_2];

// Variáveis do efeito de pulinho
inicia_efeito_pulinho();

#endregion

#region Métodos

// Movimento e Colisão do player  ===========================

// Método para pegar os inputs do player
pega_inputs = function()
{
    // Teclado
    left        = keyboard_check(ord("A"));
    right       = keyboard_check(ord("D"));
    top         = keyboard_check(ord("W"));
    down        = keyboard_check(ord("S"));
    
    // Mouse
    interagir   = mouse_check_button_pressed(mb_left);
    soltar      = mouse_check_button_pressed(mb_right);
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
    move_and_collide(velh, 0, colisao_lista, 24);
    
    // Colide na vertical
    move_and_collide(0, velv, colisao_lista, 24);
    
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

// Interação com objetos ======================================
// Método para checar se está perto de uma caixa para interagir
interage_caixa = function()
{
    // Se o player já tem um item, ele não pode pegar outro
    if (meu_item != noone) return;
        
    // Checa a caixa mais próxima na room
    var _caixa_proxima = instance_nearest(x,y, obj_bancada_caixa);
    
    // Se tiver uma caixa
    if (_caixa_proxima != noone)
    {
        // Checa uma distancia para interagir com a caixa
        var _dir = point_distance(x, y, _caixa_proxima.x, _caixa_proxima.y);
        
        if (_dir < dis_max)
        {
            // Se interagir cria um ingrediente
            if (interagir)
            {
                var _item = instance_create_layer(x, y, "ingredientes", obj_ingrediente);
                _item.image_index = _caixa_proxima.tipo_ingrediente;
                
                meu_item = _item;
                meu_item.sendo_segurado = true;
            }
        }
    }
}

//  Checa se tem um ingrediente está perto do player
checa_ingrediende = function()
{
    // Se o player já tem um item, ele não pode pegar outro
    if (meu_item != noone) return;
        
    // Checa se tem um ingrediente próximo
    var _ingrediente_proximo = instance_nearest(x, y, obj_ingrediente);
    
    if (_ingrediente_proximo != noone)
    {
        var _dis = point_distance(x, y,_ingrediente_proximo.x, _ingrediente_proximo.y);
        
        if (_dis < dis_max)
        {
            if (interagir)
            {
                meu_item = _ingrediente_proximo;
                meu_item.sendo_segurado = true;
            }
        }
    }
}

// Método para atualiza a posição do ingrediente na cabeça do player
atualiza_posicao_item = function()
{
    if (meu_item != noone)
    {
        if (instance_exists(meu_item))
        {
            meu_item.x = x;
            meu_item.y = y - 17;
            
            meu_item.depth = depth - 1;
        }
    }
    else
    {
        meu_item = noone;
    }
}

// Método para jogar o item fora
soltar_item = function()
{
    if (meu_item != noone)
    {
        if (soltar)
        {
            var _ang_mouse = point_direction(x, y, mouse_x, mouse_y);
            var _dis_mouse = point_distance(x, y, mouse_x, mouse_y);
            
            // Limita a distância máxima que o player pode arremessar
            var _dis_alvo = min(_dis_mouse, 64);
            
            var _alvo_x = x + lengthdir_x(_dis_alvo, _ang_mouse);
            var _alvo_y = y + lengthdir_y(_dis_alvo, _ang_mouse);
            
            // Checa se existe colisão na linha entre o player e o alvo pretendido
            if (collision_line(x, y, _alvo_x, _alvo_y, obj_colisao, true, true) != noone)
            {
                // Se houver uma parede, recuamos o ponto alvo até sair da colisão
                while (_dis_alvo > 0 && collision_line(x, y, _alvo_x, _alvo_y, obj_colisao, true, true) != noone)
                {
                    _dis_alvo -= 2; // Recua 2 pixels de cada vez
                    _alvo_x = x + lengthdir_x(_dis_alvo, _ang_mouse);
                    _alvo_y = y + lengthdir_y(_dis_alvo, _ang_mouse);
                }
            }    
            
            with(meu_item)
            {
                solto = true;
                sendo_segurado = false;
                alvo_x = _alvo_x;
                alvo_y = _alvo_y;
            }
            
            // Limpa a mão do player
            meu_item = noone;
        }
    }
}

// Checa se tem um prato próximo
checa_prato = function()
{
    // Se o player já estiver segurando algo como um ingrediente ou um prato, ignora
    if (meu_item != noone) return;
        
    var _prato_proximo = instance_nearest(x, y, obj_prato);
    
    if (_prato_proximo != noone)
    {
        var _dis = point_distance(x, y, _prato_proximo.x, _prato_proximo.y);
        
        if (_dis < dis_max)
        {
            if (interagir)
            {
                meu_item = _prato_proximo;
                meu_item.sendo_segurado = true;
            }
        }
    }
}

checa_bancada_prato = function()
{
    if (meu_item != noone) return;
        
    var _bancada_proxima = instance_nearest(x, y, obj_bancada_prato);
    
    if (_bancada_proxima != noone)
    {
        var _dis = point_distance(x, y, _bancada_proxima.x, _bancada_proxima.y);
        
        if (_dis < dis_max)
        {
            if (interagir)
            {
                meu_item = _bancada_proxima.gerar_prato();
                
                if (meu_item != noone)
                {
                    meu_item.sendo_segurado = true;
                }
            }
        }
    }
}

// ==========================================================

// Máquina de estados =========================================
// Método se o player estiver parado
estado_parado = function()
{
    velh = 0;
    velv = 0;
    
    // Troca a sprite dependendo de estar segurando um item ou não
    if (meu_item != noone)
    {
        sprite_index = spr_player_idl_pega;
    }
    else
    {
        sprite_index = spr_player_idl;
    }
    
    // Troca para o estado de movendo
    if (left xor right || top xor down) estado_atual = estado_movendo;
}

// Método se o player estiver se movendo
estado_movendo = function()
{
    aplica_movimento();
    
    // Troca a sprite dependendo de estar segurando um item ou não
    if (meu_item != noone)
    {
        sprite_index = spr_player_idl_pega;
    }
    else
    {
        sprite_index = spr_player_idl;
    }
    
    // Troca para o estada de parado
    if (velh == 0 && velv == 0) estado_atual = estado_parado;
}

// Começa no estado parado
estado_atual = estado_parado;
// ==========================================================
// ==========================================================
#endregion