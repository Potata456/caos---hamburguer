
checa_itens = function()
{
    var _col_ingrediente    = instance_place(x, y, obj_ingrediente);
    var _col_prato          = instance_place(x, y, obj_prato);
    
    if (_col_ingrediente)
    {
        if (_col_ingrediente.solto) instance_destroy(_col_ingrediente);
    }
    if (_col_prato)
    {
        if (_col_prato.solto) instance_destroy(_col_prato);
    }
}