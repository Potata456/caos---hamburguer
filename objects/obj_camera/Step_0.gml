if (!instance_exists(alvo)) exit;
    
// Zoom da camera
var _cam = view_camera[0];

// Define qual deve ser o zoom alvo baseado no alarme
var _zoom_alvo = global.carne_queimada ? zoom_emergemcia : zoom_normal;

// Transição suave de zoom
zoom_atual = lerp(zoom_atual, _zoom_alvo, vel_suavidade);

// Aplica a nova largura e altura da visão proporcionalmente
var _largura_zoom = largura_base * zoom_atual;
var _altura_zoom = altura_base * zoom_atual;

camera_set_view_size(_cam, _largura_zoom, _altura_zoom);

// Segue o alvo
// Centraliza a câmera no alvo levando em conta a nova largura/altura do zoom
var _x_alvo = alvo.x - (_largura_zoom / 2);
var _y_alvo = alvo.y - (_altura_zoom / 2);

// Limita a câmera para não mostrar fora da Room
_x_alvo = clamp(_x_alvo, 0, room_width - _largura_zoom);
_y_alvo = clamp(_y_alvo, 0, room_height - _altura_zoom);

// Transição suave de posição
var _x_atual = camera_get_view_x(_cam);
var _y_atual = camera_get_view_y(_cam);

var _novo_x = lerp(_x_atual, _x_alvo, vel_suavidade);
var _novo_y = lerp(_y_atual, _y_alvo, vel_suavidade);

camera_set_view_pos(_cam, _novo_x, _novo_y);