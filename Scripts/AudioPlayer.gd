extends Node

func _ready():
	pass
	
func play(SampleName):
	get_node("SamplePlayer").play(SampleName)
	pass
