extends "res://Scripts/Enemigos.gd"

const ESCENA_LASER = preload("res://Scenes/LaserEnemigo.tscn")

func _ready():
	velocidad.x = choose([velocidad.x, -velocidad.x])
	yield(create_timer(1.5), "timeout")
	disparar()
	pass
	
func _process(delta):
	if get_pos().x >= get_viewport_rect().size.width - 16:
		velocidad.x = -abs(velocidad.x)
	if get_pos().x <= 0 + 16:
		velocidad.x = abs(velocidad.x)
	pass
	
func disparar():
	while(true):
		var laser = ESCENA_LASER.instance()
		laser.set_pos(get_node("Canon").get_global_pos())
		get_main_node().add_child(laser)
		yield(create_timer(1.5), "timeout")
	pass

func choose(choises):
	randomize()
	var rand_index = randi() % choises.size()
	return choises[rand_index]
	pass

func get_main_node():
	var root = get_tree().get_root()
	return root.get_child( root.get_child_count()-1 )
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