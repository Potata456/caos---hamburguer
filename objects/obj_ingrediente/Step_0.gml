vai_para_longe();

checa_grelha();

depth = -y;

passo_timer += vel_passo;


if (estado_carne == INGREDIENTE.CARNE_QUEIMADA)
{
    // Cria partícula de fumaça
    part_particles_create(
            obj_maneger_particulas.sys_particulas, 
            x + random_range(-4, 4), 
            y - 4, 
            obj_maneger_particulas.part_fumaca, 
            1
        );
}

// Para corigir um bug que se o player soltase um ingrediente detro de uma caixa o ingrediente ficava
//preço detro dela. Não é a melhor forma mais foi o que deu para fazer :D
if (instance_place(x, y, obj_bancada_caixa) && !sendo_segurado && !solto)
{
    instance_destroy();
}