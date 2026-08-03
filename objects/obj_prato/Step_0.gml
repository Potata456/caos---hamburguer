col_prato();

// Se o prato foi arremessado
if (solto)
{
    // Move suavemente até o destino
    x = lerp(x, alvo_x, vel_voo);
    y = lerp(y, alvo_y, vel_voo);
    
    // Quando chegar perto do destino, para
    if (point_distance(x, y, alvo_x, alvo_y) < 1)
    {
        x = alvo_x;
        y = alvo_y;
        solto = false;
    }
}