#region Variáveis

muda_efeito = false;
tempo_efeito = game_get_speed(gamespeed_fps) - 30;
timer_efeito = tempo_efeito;

inicia_efeito_pulinho(0.10, 0.1, 2);
aplica_efeito_squash_stretch();

#endregion

#region Métodos

// Método para criar pratos
gerar_prato = function()
{
    // Cria o prato na posição da bancada
    var _prato = instance_create_layer(x, y - 5, "objetos", obj_prato);
    muda_efeito = true;
    aplica_efeito_squash_stretch(1.5, 0.5);
    return _prato;
}

#endregion