#region Variáveis

// Estados do cliente
enum ESTADO_CLIENTE
{
    ENTRADA,
    ANDANDO,
    SAINDO_FELIZ,
    SAINDO_RAIVA
}

// Variáveis de controle do movimento
vel = 0.3;
velh = 0;
velv = 0;

// Maquina de estados
estado_atual = ESTADO_CLIENTE.ENTRADA;

// Tempo para mudar de direção
tempo_direcao = game_get_speed(gamespeed_fps) * 3;
timer_direcao = 60;

// Tempo de paciencia do cliente
tempo_paciencia  = game_get_speed(gamespeed_fps) * 30; // 30 segundos de espera
timer_paciencia = tempo_paciencia ;

// Array para armazenar o petido do cliente
pedido = [];

#endregion

#region Métodos

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
        INGREDIENTE.TOMATE,
        INGREDIENTE.ALFACE,
        INGREDIENTE.CEBOLA,
        INGREDIENTE.PICLES
    ];
    
    // Quantidade de ingretientes não obrigatórios
    var _qtd = array_length(_opcoes_ingredientes) - 1;
    
    // Quantidade de sorteios
    var _qtd_sort = irandom_range(0, _qtd);
    
    for (var i = 0; i < _qtd_sort; i++)
    {
        var _sorteio = _opcoes_ingredientes[irandom(_qtd)];
        array_push(pedido, _sorteio);
    }
    
    // Regra 4: Sempre vai ter o pão de cima
    array_push(pedido, INGREDIENTE.PAO_CIMA);
}

// Método para maquina de estados
maquina_estados = function ()
{
    switch (estado_atual)
    {
        case ESTADO_CLIENTE.ENTRADA: // ENTRADA
            y -= vel;
            
            if (y <= room_height - 30)
            {
                estado_atual = ESTADO_CLIENTE.ANDANDO;
            }
            break;
    	case ESTADO_CLIENTE.ANDANDO: // ANDANDO
            // Atualiza o temporizador de direção
            
            olha_certo();
            
            timer_direcao--;
            if (timer_direcao <= 0)
            {
                muda_direcao();
                timer_direcao = tempo_direcao;
            }
            
            // Move e verifica colisão com o obj_colisao
            // Colide na horizontal
            var _colisao = move_and_collide(velh * vel, velv * vel, obj_colisao, 24);
            
            if (array_length(_colisao) > 0)
            {
                muda_direcao();
                timer_direcao = tempo_direcao;
            }
            
            // Verifica se colidiu com algum prato no salão
            var _prato_proximo = instance_place(x, y, obj_prato);
            
            if (_prato_proximo != noone)
            {
                if (_prato_proximo.hamburguer_pronto)
                {
                    var _pedido_correto = confere_entrega(_prato_proximo);
                    
                    if (_pedido_correto)
                    {
                        show_message("Cliente recebeu o pedido correto!");
                        
                        // Troca o estado do cliente para ir embora
                        estado_atual = ESTADO_CLIENTE.SAINDO_FELIZ;
                    }
                    else
                    {
                        show_message("Pedido errado fornecido ao cliente!");
                        
                        // Troca o estado do cliente para ir embora
                        estado_atual = ESTADO_CLIENTE.SAINDO_RAIVA;
                    }
                    
                    // Destrói o prato entregue
                    instance_destroy(_prato_proximo);
                }
            }
            
            // Atualiza o temporizador de paciencia do cliente
            timer_paciencia--
            show_debug_message(timer_paciencia);
            if (timer_paciencia <= 0)
            {
                estado_atual = ESTADO_CLIENTE.SAINDO_RAIVA;
            }
            
            break;
        
        case ESTADO_CLIENTE.SAINDO_RAIVA: // SAINDO
            image_blend = c_red;
            
            y += vel;
    
            if (y > room_height + 32)
            {
                instance_destroy();
            }
            break
        
        case ESTADO_CLIENTE.SAINDO_FELIZ:
            image_blend = c_yellow;
            
            y += vel;
    
            if (y > room_height + 32)
            {
                instance_destroy();
            }
            break;
    }
}

// Método para conferir se o prato que o player fez é igual p petido do cliente
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
            return false; // Encontrou ingrediente divergente
        }
    }
    
    return true; // Todos os ingredientes batem exatamente!
}

#endregion

// Gera o pedido inicial assim que o cliente é criado
gera_pedido_aleatorio();