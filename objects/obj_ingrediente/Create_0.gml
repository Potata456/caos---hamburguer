#region Variáveis

// Variável de controle para saber se o ingrediente está solto
solto = false;
sendo_segurado = false;

// Variável de controle para saber até aonde o ingrediente tem que ir se for jogado
alvo_x = x;
alvo_y = y;

// Velocidade de voo do ingrediente
vel_voo = 0.15;

// Preparo da carne
estado_carne = INGREDIENTE.CARNE_CRUA;
tempo_cozimento = 0;

tempo_para_assar    = game_get_speed(gamespeed_fps) * 5; // 5 segundos para assar
tempo_para_queimar  = game_get_speed(gamespeed_fps) * 10; // 10 segundos para queimar

inicia_efeito_pulinho(0.1, 0.15, 2);

// Função para pegar a cor atualizada do ingrediente
pega_cor_estilhaco = function()
{
    switch (image_index)
    {
        case INGREDIENTE.TOMATE:         return make_color_rgb(142, 9, 9);
        case INGREDIENTE.CEBOLA:         return make_color_rgb(158, 32, 118);
        case INGREDIENTE.QUEIJO:         return make_color_rgb(232, 224, 72);
        case INGREDIENTE.ALFACE:         return make_color_rgb(120, 204, 61);
        case INGREDIENTE.PICLES:         return make_color_rgb(181, 254, 112);
        case INGREDIENTE.PAO_BAIXO:      return make_color_rgb(143, 86, 59);
        case INGREDIENTE.PAO_CIMA:       return make_color_rgb(143, 86, 59);
        case INGREDIENTE.CARNE_CRUA:     return make_color_rgb(217, 87, 99);
        case INGREDIENTE.CARNE_ASSADA:   return make_color_rgb(70, 21, 21);
        case INGREDIENTE.CARNE_QUEIMADA: return make_color_rgb(22, 15, 13);
        default:                         return c_white;
    }
}

#endregion

#region Métodos

// Método para jogar o ingrediente para longe
vai_para_longe = function()
{
    // Checa se o objeto está solto
    if (solto)
    {
        // Calcula as próximas posições
        var _next_x = lerp(x, alvo_x, vel_voo);
        var _next_y = lerp(y, alvo_y, vel_voo);
        
        if (instance_exists(obj_maneger_particulas))
        {
            obj_maneger_particulas.solta_estilhaco(
                x + random_range(-2, 2), 
                y + random_range(-2, 2), 
                pega_cor_estilhaco(), 
                1
            );
        }
        
        // Trava o movimento se a próxima posição for colidir com a parede
        if (place_meeting(_next_x, _next_y, obj_colisao))
        {
            solto = false;
            alvo_x = x;
            alvo_y = y;
        }
        else
        {
            x = _next_x;
            y = _next_y;
        }
        
        // Encerra o voo se estiver próximo do alvo
        if (point_distance(x, y, alvo_x, alvo_y) < 1)
        {
            x = alvo_x;
            y = alvo_y;
            
            solto = false;
        }
    }
}

// Checa o ingrediente carne está na grelhar
checa_grelha = function()
{
    if (sendo_segurado) return;
        
    var _col_grelha = instance_place(x, y, obj_prepara_carne);
    
    if (_col_grelha)
    {
        if (image_index == INGREDIENTE.CARNE_CRUA || image_index == INGREDIENTE.CARNE_ASSADA)
        {
            tempo_cozimento++;
            
            // Cria partícula de fritura
            part_particles_create(
                obj_maneger_particulas.sys_particulas, 
                x + random_range(-6, 6), 
                y - 2 + random_range(-2, 2), 
                obj_maneger_particulas.part_fritura, 
                1
            );
            
            // Muda para ASSADA
            if (tempo_cozimento >= tempo_para_assar && tempo_cozimento < tempo_para_queimar)
            {
                if (estado_carne != INGREDIENTE.CARNE_ASSADA)
                {
                    estado_carne = INGREDIENTE.CARNE_ASSADA;
                    image_index = INGREDIENTE.CARNE_ASSADA;
                }
            }
            // Muda para QUEIMADA
            else if (tempo_cozimento >= tempo_para_queimar)
            {
                if (estado_carne != INGREDIENTE.CARNE_QUEIMADA)
                {
                    estado_carne = INGREDIENTE.CARNE_QUEIMADA;
                    image_index = INGREDIENTE.CARNE_QUEIMADA;
                    
                    // Deixa todos os clientes em panico
                    with(obj_cliente)
                    {
                        panico_carne_queimada();
                    }
                }
            }
        }
    }
}

#endregion 