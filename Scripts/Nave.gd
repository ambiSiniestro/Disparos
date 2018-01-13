extends Area2D

func _ready():
	set_process(true)
	pass

func _process(delta):
	
	var motion = (get_global_mouse_pos().x - get_pos().x) * 0.1
	translate(Vector2(motion, 0))
	#var tamanio_vista = get_viewport_rect().size
	#var pos = get_pos()
	#pos.x = clamp(pos.x, 0+16, tamanio_vista.width - 16)
	var pos = get_pos()
	pos.x = clamp(get_pos().x, 0+16, get_viewport_rect().size.width-16)
	set_pos(pos)
	pass