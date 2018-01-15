extends Area2D

var velocidad = Vector2(0, 200)

func _ready():
	set_process(true)
	pass

func _process(delta):
	translate(velocidad * delta)
	
	if get_pos().y >= get_viewport_rect().size.height + 7:
		queue_free()
	pass