extends Node2D
class_name ActiveComponent

var ACTIVES_GROUP = 'actives'

@export var isActive := false:
	set(new_value):
		isActive = new_value
		if isActive:
			$'.'.add_to_group(ACTIVES_GROUP)
			$'..'.scale = Vector2(1.25, 1.25)
		else: 
			$'.'.remove_from_group(ACTIVES_GROUP)
			$'..'.scale = Vector2(1.0, 1.0)

func set_active(active: bool):
	isActive = active
