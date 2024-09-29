extends Node2D
class_name ActiveComponent

var ACTIVES_GROUP = 'active'

@export var isActive := false:
	set(new_value):
		isActive = new_value
		if isActive:
			owner.add_to_group(ACTIVES_GROUP)
		else: 
			owner.remove_from_group(ACTIVES_GROUP)
		$ActiveHint.visible = isActive
		
func _ready() -> void:
	$ActiveHint.visible = isActive
	#TODO: сделать автоконнект к родительскому компоненту
	#owner.connect('set_active', set_active)
	
	
## Сигнал для изменения всех активных нод
func set_active(active: bool):
	print('SET ACTIVE', active)
	isActive = active
	
