#region Variáveis

// Alvo da camera
alvo = obj_player;

// Resolução base
largura_base    = 320;
altura_base     = 180

// Fator de Zoom
zoom_atual      = 1;
zoom_normal     = 1;
zoom_emergemcia = 1.1;

// Suavidade do movimento e do zoom
vel_suavidade = 0.1;

// Ajusta a View inicial
var _cam = view_camera[0];
camera_set_view_size(_cam, largura_base, altura_base);

#endregion 