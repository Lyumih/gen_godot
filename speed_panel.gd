extends HBoxContainer

@export var turn := 1:
	set(new_value):
		turn = new_value
		update_panel()

func _ready():
	update_panel()
		
# Обновляет шкалу скорости хода на панели
func update_panel(): 
	$Turn.text = 'Ход: ' + str(turn)
	var units = get_tree().get_nodes_in_group('units')
	# TODO sort by speed
	units.sort_custom(func(a: Node, b: Node): return a.speed_component.speed <  b.speed_component.speed)
	for unit in $UnitPanel.get_children():
		unit.queue_free()
	
	for unit in units:
		var unitBattle = Button.new()
		var speed = unit.speed_component.speed if 'speed_component' in unit else '?'
		unitBattle.text = str(unit.unit_name if 'unit_name' in unit else unit.name) + ' ' + str(speed)
		$UnitPanel.add_child(unitBattle)
