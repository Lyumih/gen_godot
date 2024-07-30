extends VBoxContainer

@export var aspects: Array[PackedScene] = []

func _ready():
	#var aspect_item = load("res://aspect.tscn").instantiate()
	#$AspectList.add_child(aspect_item)
	#$AspectList.add_child(aspect_item)
	print('all aspects', aspects)
	for aspect in aspects:
		var aspect_item = load("res://aspect.tscn").instantiate()
		aspect_item.aspect = aspect
		$AspectList.add_child(aspect_item)
