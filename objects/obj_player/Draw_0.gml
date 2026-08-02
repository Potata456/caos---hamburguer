draw_self();

draw_circle(x, y, 20, 2);

if (estado_atual == estado_parado)
{
    draw_text(20, 20, "parado");
}
else if (estado_atual == estado_movendo)
{
    draw_text(20, 20, "movendo");
}