#region Variáveis



#endregion

#region Métodos

// Método para criar pratos
gerar_prato = function()
{
    // Cria o prato na posição da bancada
    var _prato = instance_create_layer(x, y - 5, "objetos", obj_prato);
    return _prato;
}

#endregion

// if (!instance_exists(obj_prato)) instance_create_layer(x, y - 5, "objetos", obj_prato);