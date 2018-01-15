extends Sprite

const SCENE_MUNDO = preload("res://Stages/Mundo.tscn")

func _ready():
	
	randomize()
	set_rot(deg2rad(rand_range(0, 360)))
	
	get_node("Smog").set_emitting(true)
	get_node("Llama").set_emitting(true)
	
	utils.remote_call("Camara", "sacudir", 8, 0.2)
	AudioPlayer.play("explosion")
	
	get_node("Animacion").play("Desvanecer")
	yield(get_node("Animacion"), "finished")
	queue_free()
	
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
	
func remote_call(src_node, method, arg0 = null, arg1 = null):
	src_node = find_node(src_node)
	if src_node and src_node.has_method(method):
		if arg0 and arg1:
			return src_node.call(method, arg0, arg1)
		if arg0:
			return src_node.call(method, arg0)
		return src_node.call(method)
	pass