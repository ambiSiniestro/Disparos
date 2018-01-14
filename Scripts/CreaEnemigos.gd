extends Node

const ENEMIGOS = [
preload("res://Scenes/EnemigoKamikaze.tscn"),
preload("res://Scenes/EnemigoDispara.tscn")
]

func _ready():
	aparecer()
	pass

func aparecer():
	while true:
		randomize()
		var enemigo = choose(ENEMIGOS).instance()
		var posicion = Vector2()
		posicion.x = rand_range(0 + 16, get_viewport().get_visible_rect().size.width - 16)
		posicion.y = 0 - 16
		enemigo.set_pos(posicion)
		get_node("Contenedor").add_child(enemigo)
		yield(create_timer(rand_range(0.5, 1.25)), "timeout")
	pass
	
func create_timer(wait_time):
	var timer = Timer.new()
	timer.set_wait_time(wait_time)
	timer.set_one_shot(true)
	timer.connect("timeout", timer, "queue_free")
	add_child(timer)
	timer.start()
	return timer
	pass
	
func choose(choises):
	randomize()
	var rand_index = randi() % choises.size()
	return choises[rand_index]
	pass