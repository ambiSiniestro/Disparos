extends TextureFrame

var puntaje = 0 setget set_puntaje

func _ready():
	pass

func set_puntaje(nuevoPuntaje):
	puntaje = nuevoPuntaje
	get_node("Label").set_text(str(puntaje))
	pass