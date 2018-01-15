extends Node

const POWERUPS = [
preload("res://Scenes/PowerUpEnergia.tscn"),
preload("res://Scenes/PowerUpLaser.tscn")
]

func _ready():
	yield(create_timer(rand_range(10, 15)), "timeout")
	aparecer()
	pass

func aparecer():
	while true:
		randomize()
		var powerup = choose(POWERUPS).instance()
		var posicion = Vector2()
		posicion.x = rand_range(0 + 7, get_viewport().get_visible_rect().size.width - 7)
		posicion.y = 0 - 7
		powerup.set_pos(posicion)
		get_node("Contenedor").add_child(powerup)
		yield(create_timer(rand_range(10, 15)), "timeout")
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