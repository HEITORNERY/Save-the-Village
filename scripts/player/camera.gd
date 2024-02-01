extends Camera2D

# Variável para guardar referência ao cenário
@export var tilemap : TileMap

func _ready() -> void:
	var mapRect = tilemap.get_used_rect() # Retorna um retângulo com todos os blocos usados no mapa 
	# variável para manipular o mapa de blocos
	var tileSize = tilemap.cell_quadrant_size
	# Variável para o tamanho do mundo em pixels
	var worldSizePixels = mapRect.size * tileSize
	# Usar esse tamanho para definir os limites da câmera
	limit_right = worldSizePixels.x
	limit_bottom = worldSizePixels.y
