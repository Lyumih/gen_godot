extends Node2D
class_name TurnComponent

@export var turn := 0

func next_turn():
	print('Next turn')
	var units = get_tree().get_nodes_in_group('speeds') as Array[Player]
	if units:
		units.sort_custom(func(a, b): return a.speed > b.speed)
		units[0].tick()
		get_tree().call_group('actives', 'set_active', false)
		get_tree().call_group('targets', 'set_target', false)
		units[0].get_node('../ActiveComponent').isActive = true
		print(units[0])
		#get_tree().call_group('speeds', 'tick')
		prints('next_turn', turn, get_tree().get_nodes_in_group('speeds'), units[0].speed)
		turn += 1
