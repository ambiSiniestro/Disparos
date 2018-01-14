extends Area2D

const ESCENA_LASER = preload("res://Scenes/LaserNave.tscn")

func _ready():
	set_process(true)
	yield(create_timer(0.5), "timeout")
	disparar()
	pass

func _process(delta):
	var motionX = (get_global_mouse_pos().x - get_pos().x) * 0.1
	#var motionY = (get_global_mouse_pos().y - get_pos().y) * 0.1
	translate(Vector2(motionX, 0))
	var pos = get_pos()
	pos.x = clamp(pos.x, 0 + 16, get_viewport_rect().size.width - 16)
	#pos.y = clamp(pos.y, 0 + 16, get_viewport_rect().size.height - 16)
	set_pos(pos)
	pass

func disparar():
	while true:
		var pos_izq = get_node("Canon/Izquierda").get_global_pos()
		var pos_der = get_node("Canon/Derecha").get_global_pos()
		crea_laser(pos_izq)
		crea_laser(pos_der)
		yield(create_timer(0.25), "timeout")
	pass

func crea_laser(pos):
	var laser = ESCENA_LASER.instance()
	laser.set_pos(pos)
	get_main_node().add_child(laser)
	pass
	
func get_main_node():
	var root = get_tree().get_root()
	return root.get_child(root.get_child_count() - 1)
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
