extends Area2D

export var velocidad = Vector2()
export var armadura = 2 setget set_armadura
const ESCENA_EXPLOSION = preload("res://Scenes/Explosion.tscn")

func _ready():
	set_process(true)
	add_to_group("enemigos")
	connect("area_enter", self, "_al_entrar_al_area")
	pass

func _process(delta):
	translate(velocidad * delta)
	if get_pos().y - 16 > get_viewport_rect().size.height:
		queue_free()
	pass
	
func set_armadura(nuevoValor):
	if is_queued_for_deletion(): return
	armadura = nuevoValor
	
	if armadura < nuevoValor: AudioPlayer.play("hit_enemy")
	
	if armadura <= 0: 
		get_main_node().find_node("CuadroTexto").puntaje += 5
		crear_explosion()
		queue_free()
	pass
	
func _al_entrar_al_area(otro):
	if otro.is_in_group("nave"):
		otro.armadura -= 1
		crear_explosion()
		queue_free()
	pass
	
func crear_explosion():
	var explosion = ESCENA_EXPLOSION.instance()
	explosion.set_pos(get_pos())
	get_main_node().add_child(explosion)
	pass
	
func get_main_node():
	var root = get_tree().get_root()
	return root.get_child(root.get_child_count() - 1)
	pass