extends Area2D

var armadura = 4 setget set_armadura
var es_doble_disparo = false setget set_doble_disparo

const ESCENA_LASER = preload("res://Scenes/LaserNave.tscn")
const ESCENA_EXPLOSION = preload("res://Scenes/Explosion.tscn")
const ESCENA_FLASH = preload("res://Scenes/Flash.tscn")

signal cambio_en_armadura

func _ready():
	set_process(true)
	add_to_group("nave")
	yield(create_timer(0.5), "timeout")
	disparar()
	pass

func _process(delta):
	var motionX = (get_global_mouse_pos().x - get_pos().x) * 0.1
	var motionY = (get_global_mouse_pos().y - get_pos().y) * 0.1
	translate(Vector2(motionX, motionY))
	var pos = get_pos()
	pos.x = clamp(pos.x, 0 + 16, get_viewport_rect().size.width - 16)
	pos.y = clamp(pos.y, 0 + 16, get_viewport_rect().size.height - 16)
	set_pos(pos)
	pass

func disparar():
	while true:
		var pos_izq = get_node("Canon/Izquierda").get_global_pos()
		var pos_der = get_node("Canon/Derecha").get_global_pos()
		crea_laser(pos_izq)
		crea_laser(pos_der)
		
		if es_doble_disparo:
			var laser_izq = crea_laser(pos_izq)
			var laser_der = crea_laser(pos_der)
			laser_izq.velocidad.x = -25
			laser_der.velocidad.x = 25 
		yield(create_timer(0.25), "timeout")
	pass

func crea_laser(pos):
	var laser = ESCENA_LASER.instance()
	laser.set_pos(pos)
	get_main_node().add_child(laser)
	return laser
	pass
	
func set_armadura(nuevoValor):
	if nuevoValor > 4: return
	
	if nuevoValor < armadura:
		AudioPlayer.play("hit_ship")
		get_main_node().add_child(ESCENA_FLASH.instance())
		
	armadura = nuevoValor
	emit_signal("cambio_en_armadura", armadura)
	
	if armadura <= 0: 
		crea_explosion()
		queue_free()
	pass
	
func crea_explosion():
	var explosion = ESCENA_EXPLOSION.instance()
	explosion.set_pos(get_pos())
	get_main_node().add_child(explosion)
	pass

func set_doble_disparo(nuevoValor):
	es_doble_disparo = nuevoValor
	
	if es_doble_disparo: 
		yield(create_timer(5), "timeout")
		es_doble_disparo = false
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
