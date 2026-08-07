#region Variáveis

lista_colisao = [obj_colisao, obj_colisao_2];

// Temporizador para o spawn das poças
tempo_poca = game_get_speed(gamespeed_fps) * 1.5;
timer_poca = 0;

#endregion

// Método para spawnar poças de água com segurança
cria_poca_agua = function()
{
    // Margem para a poça não spawnar colada na borda da tela
    var _margem = 32;
    
    // Sorteia uma posição X e Y dentro da câmera respeitando a margem
    var _spawn_x = random_range(_margem, room_width - _margem);
    var _spawn_y = random_range(_margem, room_height - _margem);
    
    // Checa se na posição sorteada existe alguma colisão
    var _colidio = false;
    for (var i = 0; i < array_length(lista_colisao); i++)
    {
        if (position_meeting(_spawn_x, _spawn_y, lista_colisao[i]))
        {
            _colidio = true;
            break;
        }
    }
    
    // Se NÃO colidiu com nenhum objeto da lista, cria a poça!
    if (!_colidio)
    {
        instance_create_layer(_spawn_x, _spawn_y, "pocas", obj_poca_agua);
    }
}