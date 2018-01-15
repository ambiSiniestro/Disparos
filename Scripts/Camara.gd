extends Camera2D

var magnitud = 0
var tiempoRestante = 0
var estaSacudiendose = false

func _ready():
	pass

func sacudir(nuevaMagnitud, nuevoTiempoRestante):
	if magnitud > nuevaMagnitud: return
	magnitud = nuevaMagnitud
	tiempoRestante = nuevoTiempoRestante
	
	if estaSacudiendose: return
	estaSacudiendose = true
	
	while tiempoRestante > 0:
		var posicion = Vector2()
		posicion.x = rand_range(-magnitud, magnitud)
		posicion.y = rand_range(-magnitud, magnitud)
		set_pos(posicion)
		tiempoRestante -= get_process_delta_time()
		yield(get_tree(), "idle_frame")
	
	estaSacudiendose = false
	magnitud = 0
	set_pos(Vector2(0, 0))
	pass