extends Node2D

class_name Skill

@export var stats: SkillStats
@export var level: LevelComponent
@export var aspects: Array[PackedScene]

var history = HistoryComponent.new()

func test():
	print("It's just skill test in SkillStats.gd file")

## Жизненный цикл использования умения. Нужно, чтобы можно переопределять в умениях только use_custom(), оставив жизненный цикл без изменений
func use():
	use_logic()
	level.upgrade_chance()
	
## Использование умения. Пепеопределяется в самом умении.
func use_logic():
	print('Skill use_logic() not implemented')
	
## Активные цели (таргеты) на данный момент
func targets():
	return get_tree().get_nodes_in_group('targets') as Array[Player]

## Источник умения
func source():
	return get_tree().get_first_node_in_group('actives') as Player
	
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
