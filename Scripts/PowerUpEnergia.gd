extends "res://Scripts/PowerUp.gd"

func _ready():
	connect("area_enter", self, "_al_entrar_al_area")
	pass

func _al_entrar_al_area(other):
	if other.is_in_group("nave"):
		other.armadura += 1
		AudioPlayer.play("powerup")
		queue_free()
	pass