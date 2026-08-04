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

#endregion

#region Métodos

// Método para jogar o ingrediente para longe
vai_para_longe = function()
{
    // Checa se o objeto está solto
    if (solto)
    {
        // Move suavimente até o alvo
        x = lerp(x, alvo_x, vel_voo);
        y = lerp(y, alvo_y, vel_voo);
        
        // Ensera o voo se estiver priximo do alvo
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
        if (image_index != INGREDIENTE.CARNE_QUEIMADA)
        {
            tempo_cozimento++;
            
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
                }
            }
        }
    }
}

#endregion 