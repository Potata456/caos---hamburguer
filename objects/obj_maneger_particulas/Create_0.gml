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

#region PARTÍCULA DE ESTILHAÇOS / FARELOS (Ao jogar para longe)

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




#region Métodos

// Método para soltar estilhaços com a cor do objeto
solta_estilhaco = function (_x, _y, _cor, _qtd)
{
    // Define a cor recebida
    part_type_color1(part_estilhaco, _cor);
    
    // Solta as partículas
    part_particles_create(sys_particulas, _x, _y, part_estilhaco, _qtd);
}

#endregion