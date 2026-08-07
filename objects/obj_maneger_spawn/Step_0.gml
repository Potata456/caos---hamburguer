if (global.carne_queimada)
{
    timer_poca--;
    if (timer_poca <= 0)
    {
        cria_poca_agua();
        timer_poca = tempo_poca;
    }
}
else
{
	timer_poca = tempo_poca;
}