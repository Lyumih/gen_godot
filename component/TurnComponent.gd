extends Node2D
class_name TurnComponent

@export var turn := 0

func next_turn():
	print('Next turn')
	var units = get_tree().get_nodes_in_group('speed') as Array[Player]
	prints(units)
	if units:
		units.sort_custom(func(a, b): return a.speed_component.speed > b.speed_component.speed)
		var unit = units[0] as Player
		unit.speed_component.tick()
		get_tree().call_group('active', 'set_active', false)
		#get_tree().call_group('targets', 'set_target', false)
		unit.active_component.set_active(true)
		turn += 1
		$HistoryComponent.add_log('🚀%s: Ходит %s' % [turn, units[0].unit_name] )
	EventBus.next_turn.emit()
