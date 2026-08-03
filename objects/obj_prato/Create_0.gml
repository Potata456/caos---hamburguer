#region Variáveis

// Array para guardar os tipos de ingredientes nos pratos
ingredientes_prato = [];

// Estado do prato
hamburguer_pronto = false;

// Variáveis de voo
solto = false;
alvo_x = x;
alvo_y = y;
vel_voo = 0.15;
sendo_segurado = false;

#endregion


#region Métodos

// Método para adicionar um ingrediente ao prato
adicionar_ingrediente = function(_tipo_ingrediente)
{
    // Se o hambúrguer já tiver o pão de cima, não aceita mais nada
    if (hamburguer_pronto) return false;
        
    var  _qtd = array_length(ingredientes_prato);
    
    // Regra 1: O primeiro item PRECISA ser o pão de baixo!
    if (_qtd == 0)
    {
        if (_tipo_ingrediente == INGREDIENTE.PAO_BAIXO)
        {
            array_push(ingredientes_prato, _tipo_ingrediente);
            return true;
        }
        return false; // Rejeita se tentar colocar outra coisa primeiro
    }
    
    // Regra 2: Se colocou o pão de cima, finaliza o hambúrguer!
    if (_tipo_ingrediente == INGREDIENTE.PAO_CIMA)
    {
        array_push(ingredientes_prato, _tipo_ingrediente);
        hamburguer_pronto = true;
        return true;
    }
    
    // Regra 3: Ingredientes do meio (só aceita se ainda não colocou o pão de cima)
    array_push(ingredientes_prato, _tipo_ingrediente);
    return true;
}

// Método para saber se um ingrediente colidio com um prato
col_prato = function()
{
    if (!sendo_segurado && !hamburguer_pronto)
    {
        var _ingrediente_proximo = instance_nearest(x, y, obj_ingrediente);
        
        if (_ingrediente_proximo != noone)
        {
            if (_ingrediente_proximo.solto)
            {
                var _dis = point_distance(x, y, _ingrediente_proximo.x, _ingrediente_proximo.y);
                if (_dis < 15)
                {
                    // Só destrói o ingrediente se ele realmente foi aceito pelo prato!
                    var _sucesso = adicionar_ingrediente(_ingrediente_proximo.image_index);
                    
                    // Detroi o ingrediente
                    if (_sucesso) instance_destroy(_ingrediente_proximo);
                }
            }
        }
    }
}

#endregion
