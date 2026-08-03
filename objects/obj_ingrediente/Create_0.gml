#region Variáveis

// Variável de controle para saber se o ingrediente está solto
solto = false;

// Variável de controle para saber até aonde o ingrediente tem que ir se for jogado
alvo_x = x;
alvo_y = y;

// Velocidade de voo do ingrediente
vel_voo = 0.15;

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

#endregion 