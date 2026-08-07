// Variáveis de controle dos efeito
muda_efeito = false;
tempo_efeito = game_get_speed(gamespeed_fps) - 30;
timer_efeito = tempo_efeito;

// Inicia variáveis de efeitos
inicia_efeito_pulinho(0.10, 0.1, 2);
inicia_efeito_squash_stretch();

// Checa se colidio com algum item
checa_itens = function()
{
    var _col_ingrediente    = instance_place(x, y, obj_ingrediente);
    var _col_prato          = instance_place(x, y, obj_prato);
    
    // Colisão com o ingrediente
    if (_col_ingrediente)
    {
        if (_col_ingrediente.solto)
        {
            if (obj_maneger_particulas)
            {
                obj_maneger_particulas.solta_fumaca_lixo(x, y - 7);
            }
            
            // Ativa efeito de colisão
            muda_efeito = true;
            aplica_efeito_squash_stretch(2, 0.5);
            
            instance_destroy(_col_ingrediente);
        }
    }
    
    // Colisão com o prato
    if (_col_prato)
    {
        if (_col_prato.solto)
        {
            if (obj_maneger_particulas)
            {
                obj_maneger_particulas.solta_fumaca_lixo(x, y - 7);
            }
            
            // Ativa efeito de colisão
            muda_efeito = true;
            aplica_efeito_squash_stretch(2, 0.5);
            
            instance_destroy(_col_prato);
        }
    }
    
    // Reseta efeito
    if (muda_efeito)
    {
        timer_efeito--;
        if (timer_efeito <= 0)
        {
            muda_efeito = false;
            timer_efeito = tempo_efeito;
        }
    }
}