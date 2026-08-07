// Pega os inputs do player, faz ele se mover, colidir e ohar para o lado certo
pega_inputs();
colisao();
olha_certo();

// Interage com objetos
interage_caixa();
checa_ingrediende();
checa_prato(); 
checa_bancada_prato();
checa_alarme();

estado_atual();

// Atualiza a posição do item e joga ele fora
atualiza_posicao_item();
soltar_item();

if (keyboard_check_pressed(ord("R"))) room_restart();
    
depth = -y;

realiza_efeito_pulinho();