extends Node2D

class_name Skill

@export var stats: SkillStats
@export var level: LevelComponent
@export var aspects: Array[PackedScene]

@onready var serializer_component: SerializerComponent = SerializerComponent.new()

var history_component: HistoryComponent = HistoryComponent.new()

func _ready() -> void:
	add_child(history_component)
	#serializer_component.hard_serialize_keys = ['level']

func test() -> bool:
	print("It's just skill test in SkillStats.gd file")
	return true

## Жизненный цикл использования умения. Нужно, чтобы можно переопределять в умениях только use_custom(), оставив жизненный цикл без изменений
func use() -> bool:
	var result = use_logic()
	if result:
		level.upgrade_chance()
		history().add_log(log_use_success())
	else:
		history().add_log(log_use_failure())
	return result

## Быстрое обращение к компоненту истории
func history():
	return history_component
	
## Логирование успешного использования умения
func log_use_success() -> String:
	if first_target() and source():
		return " %s %s 🎯%s умением 🪄%s:" % [ source().unit_name, hint(), first_target().unit_name, stats.skill_name]
	return 'ERROR'
	
## Логирование успешного использования умения
func log_use_failure() -> String:
	if source():
		return "%s: Не удалось использовать умение 🪄%s" % [source().unit_name, stats.skill_name]
	return "ERROR"

	
## Использование умения. Пепеопределяется в самом умении.
func use_logic() -> bool:
	print('Skill use_logic() not implemented')
	return false
	
## Активные цели (таргеты) на данный момент
func targets():
	return get_tree().get_nodes_in_group('targets') as Array[Player]

## Источник умения
func source():
	return get_tree().get_first_node_in_group('active') as Player
	
## Первая цель из списка целей
func first_target():
	if targets().size() > 0:
		return targets()[0].get_parent() as Player

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

func serialize():
	#return serializer_component.serialize()
	return {
		level: level.serialize()
	}
	
func deserialize(data):
	return serializer_component.deserialize(data)
