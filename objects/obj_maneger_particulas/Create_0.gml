// Cria o sistema de partículas
sys_particulas = part_system_create();

// Fica por cima dos objetos
part_system_depth(sys_particulas, -100);



#region PARTÍCULA DE FRITURA (Gordura/Óleo caindo)

part_fritura = part_type_create();

part_type_shape(part_fritura, pt_shape_pixel);

// Tamanho da partícula
part_type_size(part_fritura, 1, 2, 0, 0);

// Cor: amarelos e laranja
part_type_colour2(part_fritura, c_yellow, c_orange);
// Transparência sumindo no final
part_type_alpha2(part_fritura, 1, 0.2);

// Movimento (Caindo)
part_type_speed(part_fritura, 0.5, 1.5, -0.2, 0);
part_type_direction(part_fritura, 250, 290, 0, 0); // Apontado para baixo
part_type_gravity(part_fritura, 0.05, 270); // Gravidade puxando para baixo

// Tempo de vida
part_type_life(part_fritura, 15, 30);

#endregion

#region PARTÍCULA DE FUMAÇA (Carne Queimada)

part_fumaca = part_type_create();

part_type_shape(part_fumaca, pt_shape_pixel);

// Tamanho: Começa pequena e vai crescendo conforme sobe
part_type_size(part_fumaca, 1, 3, 0.01, 0);

// Cor: cinza escuro e preto
part_type_colour2(part_fumaca, c_dkgray, c_black);
part_type_alpha3(part_fumaca, 0.6, 0.4, 0);

// Movimento (Sobe devagar balançando)
part_type_speed(part_fumaca, 0.3, 0.8, 0, 0);
part_type_direction(part_fumaca, 70, 110, 0, 2); // Apontado para cima
part_type_gravity(part_fumaca, 0.01, 90);

// Tempo de vida
part_type_life(part_fumaca, 40, 70);

#endregion

#region PARTÍCULA DE ESTILHAÇOS (Ao jogar para longe)

part_estilhaco = part_type_create();

part_type_shape(part_estilhaco, pt_shape_pixel);

part_type_shape(part_estilhaco, pt_shape_pixel);
// Tamanho: Começa pequena e consome rápido
part_type_size(part_estilhaco, 1, 1.5, -0.05, 0);

// Movimento de Rastro
part_type_speed(part_estilhaco, 0.1, 0.4, 0, 0); // Velocidade bem baixa
part_type_direction(part_estilhaco, 0, 360, 0, 0); // Leve espalhamento
part_type_gravity(part_estilhaco, 0.02, 270); // Gravidade mínima para baixo

// Tempo de vida bem curto
part_type_life(part_estilhaco, 6, 12);

#endregion

#region PARTÍCULA DE HAMBÚRGUER PRONTO (Explosão de Sucesso)

part_pronto = part_type_create();

part_type_shape(part_pronto, pt_shape_star);

// Tamanho: Começa em tamanho médio e vai encolhendo até sumir
part_type_size(part_pronto, 0.1, 0.3, -0.01, 0);

// Cores: Amarelo, Branco e Laranja
part_type_color3(part_pronto, c_white, c_yellow, c_orange);
part_type_alpha2(part_pronto, 1, 0); // Desaparece suavemente

// Movimento: Explosão rápida para todas as direções
part_type_speed(part_pronto, 2, 4.5, -0.15, 0); // Começa veloz e desacelera bastante
part_type_direction(part_pronto, 0, 360, 0, 0);  // Espalha para todos os lados
part_type_gravity(part_pronto, 0.05, 270);        // Leve gravidade puxando para baixo no final

// Tempo de vida curto
part_type_life(part_pronto, 20, 35);

#endregion

#region PARTÍCULA DE FUMAÇA DA LIXEIRA

part_lixo = part_type_create();

part_type_sprite(part_lixo, spr_part_fumaca, false, false, false);

// Tamanho: Ajuste a escala de acordo com o tamanho original do seu desenho
part_type_size(part_lixo, 0.1, 0.3, 0.01, 0);

// Rotação: Gira a sprite aleatoriamente para dar variação a cada nuvem
part_type_orientation(part_lixo, 0, 360, 0.5, 0, false);

// Cores: branco e cinza claro
part_type_color2(part_lixo, c_white, c_ltgray);
part_type_alpha3(part_lixo, 0.8, 0.5, 0)

// Movimento: Sobe se espalhando para cima
part_type_speed(part_lixo, 0.4, 1.0, -0.01, 0);
part_type_direction(part_lixo, 45, 135, 0, 2);
part_type_gravity(part_lixo, 0.01, 90);

// Tempo de vida
part_type_life(part_lixo, 25, 45);

#endregion

#region PARTÍCULA DE CHUVA (Sprinkler de Emergência)

part_chuva = part_type_create();

part_type_sprite(part_chuva, spr_part_gota, false, false, false);

// Tamanho: Fina e levemente esticada na vertical
part_type_size(part_chuva, 0.1, 0.25, 0, 0);
part_type_scale(part_chuva, 1, 1);

// Cor: Azul claro / Ciano transparente
part_type_color2(part_chuva, c_aqua, c_white);
part_type_alpha2(part_chuva, 0.8, 0.1);

// Movimento: Caindo rápido na diagonal
part_type_speed(part_chuva, 4, 7, 0, 0);
part_type_direction(part_chuva, 245, 255, 0, 0); // Leve inclinação para a esquerda

// Orientação: Mantém a gotinha virada para a direção do movimento
part_type_orientation(part_chuva, 245, 255, 0, 0, false);

// Tempo de vida curto
part_type_life(part_chuva, 50, 80);

#endregion

#region Métodos

// Método para soltar estilhaços com a cor do objeto
solta_estilhaco = function (_x, _y, _cor, _qtd)
{
    // Define a cor recebida
    part_type_color1(part_estilhaco, _cor);
    
    // Solta as partículas
    part_particles_create(sys_particulas, _x, _y, part_estilhaco, _qtd);
}

// Método para soltar a explosão de hambúrguer pronto
solta_sucesso_pronto = function(_x, _y, _qtd)
{
    part_particles_create(sys_particulas, _x, _y, part_pronto, _qtd);
}

// Método para soltar fumaça na lixeira
solta_fumaca_lixo = function(_x, _y)
{
    part_particles_create(sys_particulas, _x + random_range(-4, 4), _y + random_range(-2, 2), part_lixo, 10);
}

// Método para gerar a chuva pela tela inteira
chover_sprinkler = function()
{
    // Pega os limites visíveis da câmera atual
    var _cam = view_camera[0];
    var _cam_x = camera_get_view_x(_cam);
    var _cam_y = camera_get_view_y(_cam);
    var _cam_w = camera_get_view_width(_cam);
    var _cam_h = camera_get_view_height(_cam);
    
    // Solta várias gotas no topo e pelas laterais da câmera para cobrir a tela inteira
    repeat (6)
    {
        var _rx = random_range(_cam_x - 50, _cam_x + _cam_w + 100);
        var _ry = random_range(_cam_y - 60, _cam_y - 10);

        part_particles_create(sys_particulas, _rx, _ry, part_chuva, 1);
    }
}

#endregion