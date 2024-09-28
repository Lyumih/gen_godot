extends Node

class_name Skill

@export var stats: SkillStats
@export var level: LevelComponent
@export var aspects: Array[PackedScene]

var history = HistoryComponent.new()

func test():
	print("It's just skill test in SkillStats.gd file")
	
## Использование умения
func use():
	print('Skill use() not implemented')

## Активные цели (таргеты) на данный момент
func targets():
	return get_tree().get_nodes_in_group('targets')

## Источник умения
func source():
	return get_tree().get_first_node_in_group('actives')
	
## Первая цель из списка целей
func first_target():
	if targets().size() > 0:
		return targets()[0].get_parent()

## Подсказка с вычисленными значениями
func hint() -> String:
	print('Skill hint() not implemented')
	return 'Skill hint() not implemented'
	
## Вычисленные переменные значений для более упрощённого подсчёта формул
func calc_values():
	print('Skill calc_values() not implemented')
	return {}
	
func disabled():
	return true
