#region Variáveis

// Variáveis de controle do movimento
vel = 0.3;
velh = 0;
velv = 0;

// Tempo para mudar de direção
tempo_direcao = game_get_speed(gamespeed_fps) * 3;
timer_direcao = 60;

// Tempo de paciencia do cliente
tempo_paciencia  = game_get_speed(gamespeed_fps) * 35; // 35 segundos de espera
timer_paciencia = tempo_paciencia ;

// Array para armazenar o petido do cliente
pedido = [];

// Variáveis de controle para o estado de escorregar
dir = 1;
forca_giro = 6;
max_giro = 90;
pode_voltar = false;
tempo_escorrega = game_get_speed(gamespeed_fps) * 1;
timer_escorrega = tempo_escorrega;

tempo_escorrega_novo = game_get_speed(gamespeed_fps) * 2;
timer_escorrega_novo = 0;

// Variáveis de controle para o estado de vomito
tempo_vomito = game_get_speed(gamespeed_fps) * 2;
timer_vomito = tempo_vomito;

// Variáveis de controle para o estado de panico
tempo_panico = game_get_speed(gamespeed_fps) * 5;
timer_panico = tempo_panico;
dis_max = 50; // Campo de visão
cont_panico = 0; // Conta quantas vezes o cliente entrou um panico

// Lista de colisões com objetos
colisao_lista = [obj_colisao, obj_colisao_2];


// Variáveis do efeito de pulinho
inicia_efeito_pulinho(0.2, 0.12, 5);

#endregion



#region Métodos

checa_agua = function()
{
    // Checa se colidio com uma poça de agua
    var _col_poca_agua = instance_place(x, y, obj_poca_agua)
    if (_col_poca_agua != noone && timer_escorrega_novo <= 0)
    {
        estado_atual = estado_escorrega;
    }
    else
    {
    	timer_escorrega_novo--;
    }
}

checa_vomito = function()
{
    // Checa se colidio com uma poça de vomito
    var _col_poca_vomito = instance_place(x, y, obj_poca_vomito)
    if (_col_poca_vomito != noone)
    {
        estado_atual = estado_vomito;
    }
}

checa_rato = function()
{
    var _rato_prox = instance_nearest(x, y, obj_rato);
    
    if (_rato_prox != noone)
    {
        var _dis = point_distance(x, y, _rato_prox.x, _rato_prox.y);
        
        if (_dis < dis_max)
        {
            cont_panico++;
            
            // Se já se assustou muitas vezes com o caos, vai embora
            if (cont_panico > 3)
            {
                estado_atual = estado_sair_raiva;
            }
            else
            {
                estado_atual = estado_panico;
            }
        }
    }
}

panico_carne_queimada = function()
{
    if (estado_atual == estado_neutro)
    {
        cont_panico++;
        
        // Se já se assustou muitas vezes com o caos, vai embora
        if (cont_panico > 3)
        {
            estado_atual = estado_sair_raiva;
        }
        else
        {
            estado_atual = estado_panico;
        }
    }
}

// Método para olhar para o lado certo
olha_certo = function()
{
    if (velh != 0)
    {
        image_xscale = sign(velh);
    }
}

// Método para mudar de direção
muda_direcao = function()
{
    // Escolhe uma direção aleatória
    velh = choose(-1, 0, 1);
    velv = choose(-1, 0, 1);
    
    if (velh == 0 && velv == 0)
    {
        velh = choose(-1, 1);
    }
    
    if (velh != 0) dir = velh;
}

// Método que gera o petido aleatório do cliente
gera_pedido_aleatorio = function()
{
    // Limpa a lista de petidos por garantia
    pedido = [];
    
    // Regra 1: Sempre vai ter pão de baixo
    array_push(pedido, INGREDIENTE.PAO_BAIXO);
    
    // Regra 2: Sempre vai ter carne
    array_push(pedido, INGREDIENTE.CARNE_ASSADA);
    
    // Regra 3: Os outros ingredientes são aleatória e a quantidade também
    // Lista de ingredientes não obrigatórios no hamburguer
    var _opcoes_ingredientes =  [
        INGREDIENTE.QUEIJO,
        INGREDIENTE.ALFACE,
        INGREDIENTE.CEBOLA,
        //INGREDIENTE.TOMATE,
        // INGREDIENTE.PICLES
    ];
    
    // Quantidade de ingretientes não obrigatórios
    var _qtd_max = array_length(_opcoes_ingredientes);
    // Quantidade de sorteios
    var _qtd_sort = irandom_range(0, _qtd_max);
    
    for (var i = 0; i < _qtd_sort; i++)
    {
        // Sorteia um índice válido do array restante
        var _indice_sorteado = irandom(array_length(_opcoes_ingredientes) - 1);
        // Pega o ingrediente correspondente ao índice sorteado
        var _ingrediente = _opcoes_ingredientes[_indice_sorteado];
        
        // Adiciona ao pedido do cliente
        array_push(pedido, _ingrediente);
        
        // Remove o ingrediente do array de opções para não ser sorteado novamente!
        array_delete(_opcoes_ingredientes, _indice_sorteado, 1);
    }
    
    // Regra 4: Sempre vai ter o pão de cima
    array_push(pedido, INGREDIENTE.PAO_CIMA);
}

// Método para conferir se o prato que o player fez é igual ou petido do cliente
confere_entrega = function(_prato_entregue)
{
    var _ingredientes_prato     = _prato_entregue.ingredientes_prato;
    var _pedito_cliente         = pedido;
    
    // Se os tamanhos forem diferentes, o pedido já está errado!
    if (array_length(_ingredientes_prato) != array_length(_pedito_cliente)) return false;
        
    // Cria cópias temporárias para não alterar a ordem original das arrays do jogo
    var _tempo_prato    = array_create(array_length(_ingredientes_prato));
    var _tempo_petido   = array_create(array_length(_pedito_cliente));
    
    array_copy(_tempo_prato, 0, _ingredientes_prato, 0, array_length(_ingredientes_prato));
    array_copy(_tempo_petido, 0, _pedito_cliente, 0, array_length(_pedito_cliente));
    
    // Ordena ambas as cópias para alinhar os elementos de mesma id
    array_sort(_tempo_prato, true);
    array_sort(_tempo_petido, true);
    
    // Compara item por item
    for (var i = 0; i < array_length(_tempo_prato); i++)
    {
        if (_tempo_prato[i] != _tempo_petido[i])
        {
            return false; // Encontrou ingrediente diverentes
        }
    }
    
    return true; // Todos os ingredientes batem exatamente!
}

#endregion

// ====================================================

#region Máquina de estados

// Estados do cliente
/*
    ENTRADA      -> PRONTO
    NEUTRO       -> PRONTO
    SAIR_FELIZ   -> EM ANDAMENTO
    SAIR_RAIVA   -> EM ANDAMENTO
    SAIR_ENJOADO -> EM ANDAMENTO
    ESCORREGA    -> PRONTO
    VOMITO       -> PRONTO
    PANICO       -> PRONTO
*/

// Variável de controle da máquina de estados
estado_atual = noone;

estado_entrada = function()
{
    // Se move para cima
    y -= vel;
    
    // checa_agua();
    // checa_vomito();
    
    // Troca estado
    if (y <= 120)
    {
        // Gera o pedido inicial assim que o cliente é criado
        gera_pedido_aleatorio();
        estado_atual = estado_neutro;
    }
}

estado_neutro = function ()
{
    image_blend = c_white;
    // Olha para direção certa
    olha_certo();
    
    // Timer para trocar de direção
    timer_direcao--;
    if (timer_direcao <= 0)
    {
        muda_direcao();
        timer_direcao = tempo_direcao;
    }
    
    // Checa se colidio com uma parede
    var _col_parede = move_and_collide(velh * vel, velv * vel, colisao_lista, 24);
    if (array_length(_col_parede))
    {
        muda_direcao();
        timer_direcao = tempo_direcao;
    }
    
    // Checa se colidio com um prato pronto
    var _prato_prox = instance_place(x, y, obj_prato);
    if (_prato_prox != noone)
    {
        if (_prato_prox.hamburguer_pronto)
        {
            var _pedido_correto = confere_entrega(_prato_prox);
            
            // Pedido certo
            if (_pedido_correto)
            {
                show_message("Cliente recebeu o pedido correto!");
                // Troca o estado
                estado_atual = estado_sair_feliz;
            }
            // Pedido errado
            else
            {
                show_message("Pedido errado fornecido ao cliente!");
                // Troca o estado
                estado_atual = estado_sair_raiva;
            }
            // Destroí o prato
            instance_destroy(_prato_prox);
        }
    }
    
    // Algumas checagens de troca de estados
    checa_agua();
    checa_vomito();
    checa_rato();
    
    // Timer de paciencia do cliente
    timer_paciencia--;
    // show_debug_message(timer_paciencia);
    if (timer_paciencia <= 0)
    {
        estado_atual = estado_sair_raiva;
    }
}

estado_sair_feliz = function ()
{
    image_blend = c_yellow;
    
    y += vel;

    if (y > room_height + 32)
    {
        instance_destroy();
    }
}

estado_sair_raiva = function ()
{
    image_blend = c_red;
    
    y += vel;

    if (y > room_height + 32)
    {
        instance_destroy();
    }
}

estado_sair_enjoado = function ()
{
    image_blend = c_green;
    
    y += vel;

    if (y > room_height + 32)
    {
        instance_destroy();
    }
}

estado_escorrega = function()
{
    // Para de se mover
    if (dir == 1)
    {
       // Gira para direita
       if (!pode_voltar)
       {
           image_angle -= forca_giro;
           
           if (image_angle <= -max_giro)
           {
               image_angle = -max_giro;
               
               timer_escorrega--;
               if (timer_escorrega <= 0) pode_voltar = true;
           }
       }
       else // Gira para esquerda
       {
           image_angle += forca_giro;
           
           if (image_angle >= 0)
           {
               image_angle = 0;
               pode_voltar = false;
               
               timer_escorrega = tempo_escorrega;
               timer_escorrega_novo = tempo_escorrega_novo;
               
               muda_direcao();
               timer_direcao = tempo_direcao;
               estado_atual = estado_neutro;
           }
       }
    }
    
    // ===========================================
    
    if (dir == -1)
    {
       // Gira para direita
       if (!pode_voltar)
       {
           image_angle += forca_giro;
           
           if (image_angle >= max_giro)
           {
               image_angle = max_giro;
               
               timer_escorrega--;
               if (timer_escorrega <= 0) pode_voltar = true;
           }
       }
       else // Gira para esquerda
       {
           image_angle -= forca_giro;
           
           if (image_angle <= 0)
           {
               image_angle = 0;
               pode_voltar = false;
               
               timer_escorrega = tempo_escorrega;
               timer_escorrega_novo = tempo_escorrega_novo;
               
               muda_direcao();
               timer_direcao = tempo_direcao;
               estado_atual = estado_neutro;
           }
       }
    }
}

estado_vomito = function()
{
    // Para de se mover e fica verde
    image_blend = c_green;
    x += choose(-0.2, 0.2);
    
    timer_vomito--;
    if (timer_vomito <= 0)
    {
        instance_create_layer(x, y, "pocas", obj_poca_vomito);
        
        timer_vomito = tempo_vomito;

        estado_atual = estado_sair_enjoado;
    }
}

estado_panico = function()
{
    image_blend = c_orange;
    olha_certo();
    
    checa_agua();
    checa_vomito();
    
    timer_direcao--;
    if (timer_direcao <= 0)
    {
        muda_direcao();
        timer_direcao = tempo_direcao / 2;
    }
    
    timer_panico--;
    if (timer_panico <= 0)
    {
        timer_panico = tempo_panico;
        estado_atual = estado_neutro;
    }
    
    // Checa se colidio com uma parede
    var _vel_panico = vel * 2.5;
    var _col_parede = move_and_collide(velh * _vel_panico, velv * _vel_panico, colisao_lista, 24);
    if (array_length(_col_parede))
    {
        muda_direcao();
        timer_direcao = tempo_direcao;
    }
}

// Começa no estado de entrada
estado_atual = estado_entrada;

#endregion