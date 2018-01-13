extends Area2D


export var velocidad = Vector2()

func _ready():
	set_process(true)
	pass

func _process(delta):
	translate(velocidad * delta)
	if get_pos().y - 16 > get_viewport_rect().size.height:
		queue_free()
	pass