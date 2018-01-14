extends Area2D

export var velocidad = Vector2()
const ESCENA_LLAMA = preload("res://Scenes/Llama.tscn")

func _ready():
	set_process(true)
	crea_llama()
	yield(get_node("NotificadorVisibilidad"), "exit_screen")
	queue_free()
	pass
	
func _process(delta):
	translate(velocidad * delta)
	pass
	
func crea_llama():
	var llama = ESCENA_LLAMA.instance()
	llama.set_pos(get_pos())
	get_main_node().add_child(llama)
	pass

func get_main_node():
	var root = get_tree().get_root()
	return root.get_child( root.get_child_count()-1 )
	pass