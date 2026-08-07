// Se o alarme estiver ativo
if (global.carne_queimada)
{
    var _alpha = 0.3 + sin(current_time * 0.008) * 0.25;
    
    // Configura a cor e transparência
    draw_set_color(c_red);
    draw_set_alpha(_alpha);
    
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    // Espessura da borda vermelha em pixels
    var _espessura = 20;
    
    // Desenha as 4 bordas da tela (Cima, Baixo, Esquerda, Direita)
    draw_rectangle(0, 0, _gui_w, _espessura, false);                     // Topo
    draw_rectangle(0, _gui_h - _espessura, _gui_w, _gui_h, false);       // Baixo
    draw_rectangle(0, 0, _espessura, _gui_h, false);                     // Esquerda
    draw_rectangle(_gui_w - _espessura, 0, _gui_w, _gui_h, false);       // Direita
    
    // Reseta o alpha e a cor 
    draw_set_alpha(1);
    draw_set_color(c_white);
}