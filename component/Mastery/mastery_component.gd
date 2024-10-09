extends Node2D

## Компонент, который позволяет делать улучшения для юнита (зависит от уровня игрока).
class_name MasteryComponent

## Сигнал об улучшении мастерства персонажа
signal mastery_upgraded

### сериализация компонента улучшений
#@onready var serializer_compnent: SerializerComponent = $SerializerComponent

## Перечень доступных улучшений. "" - пустота
var upgrades_list = ["❤️2", "❤️10", "💪1", "💪4", "⚕2", "⚕6", "", "👟1"]
## Все улучшения
var all_upgrades = []

## Длина таблицы улучшений
var table_width = 3
## Общее количество улучше возможных
var table_size = table_width * table_width

## Текущее количество улучшений для юнита
@export var upgrades = {}

func _ready() -> void:
	print_debug("_READY")
	generate_all_upgrades()
			
## Генерация случайных улучшений, если ещё не было создано для персонажа
func generate_all_upgrades():
	if all_upgrades.size() == 0:
		print_debug("NEED GENERATE", all_upgrades, all_upgrades.size(), owner.unit_name, owner.owner)
		for index in table_size:
			all_upgrades.push_front(upgrades_list.pick_random())
			
## Улучшение мастерства по данному индексу, если оно есть
func mastery_upgrade(index: int):
	if not upgrades.has(index):
		upgrades[index] = all_upgrades[index]
		mastery_upgraded.emit()
		print_debug('Mastery upgraded', index)
		
	
### сериализация текущего мастерства, если нужно
func serialize():
	return $SerializerComponent.serialize()
	#return serializer_compnent.serialize()
	#print_debug(serializer_compnent)
	#if serializer_compnent:
		#print_debug(serializer_compnent.serialize())
		#return serializer_compnent.serialize()
	#else:
		#printerr('MasteryComponent not serialable. serializer_compnent = false', self)
#
### Десериализия компонента
func desirialize(data):
	return $SerializerComponent.deserialize(data)
	#return serializer_compnent.deserialize(data)
