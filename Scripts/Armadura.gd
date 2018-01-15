extends Sprite

func _ready():
	utils.attach("Nave", "cambio_en_armadura", self, "_en_cambio_en_armadura")
	pass
	
func _en_cambio_en_armadura(armadura):
	set_frame(armadura)
	pass