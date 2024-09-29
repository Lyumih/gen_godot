extends Node2D
class_name ActiveComponent

var ACTIVES_GROUP = 'actives'

@export var isActive := false:
	set(new_value):
		isActive = new_value
		if isActive:
			$'.'.add_to_group(ACTIVES_GROUP)
		else: 
			$'.'.remove_from_group(ACTIVES_GROUP)
		$ActiveHint.visible = isActive
		
func _ready() -> void:
	$ActiveHint.hide()
	

func set_active(active: bool):
	isActive = active
