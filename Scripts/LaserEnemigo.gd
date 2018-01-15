extends "res://Scripts/Laser.gd"

func _ready():
	connect("area_enter", self, "_al_entrar_al_area")
	AudioPlayer.play("laser_enemy")
	pass

func _al_entrar_al_area(otro):
	if otro.is_in_group("nave"):
		otro.armadura -= 1
		crea_llama()
		utils.remote_call("Camara", "sacudir", 3, 0.13)
		queue_free()
	pass
	
func remote_call(src_node, method, arg0 = null, arg1 = null):
	src_node = find_node(src_node)
	
	if src_node and src_node.has_method(method):
		if arg0 and arg1:
			return src_node.call(method, arg0, arg1)
		if arg0:
			return src_node.call(method, arg0)
		return src_node.call(method)
	pass