#region #endregion#region Variáveis

inicia_efeito_pulinho(0.10, 0.1, 2);

// Estado do alarme
alarme_tocando = false;

// Variáveis para controlar o piscar das luzes
// Velocidade do piscar
vel_piscar = 0.08; 

#endregion

#region Métodos

checa_incendio = function()
{
    // Se a carne queimou e o alarme ainda não estava ativo
    if (global.carne_queimada && !alarme_tocando)
    {
        alarme_tocando = true;
        
        // Toca o som do alarme
        // audio_play_sound(snd_alarme, 10, true);
        
        // Coloca todos os clientes existentes em pânico
        with (obj_cliente)
        {
            panico_carne_queimada();
        }
    }
}

#endregion