extends Sprite

func _ready():
	get_node("Animacion").play("Desvanecer")
	yield(get_node("Animacion"), "finished")
	queue_free()
	pass
