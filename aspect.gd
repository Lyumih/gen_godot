extends HBoxContainer
@export var aspect: PackedScene

var aspect_info_format = '{name} 
Уровень: {level}
Шанс прокачки: {chance}%({previous_chance}) после победы
Описание: {description}'

## Нужно зачем-то проинстанцировать эту сцену.
var _aspect

func _ready():
	print('test')
	_aspect = aspect.instantiate()
	update_info()

func update_info():
	if aspect:
		$".".show()
		$AspectInfo.text = aspect_info_format.format({
			"name":_aspect.stats.aspect_name,
			"level": _aspect.level.level,
			"chance": _aspect.level.chance,
			"previous_chance": _aspect.level.logger.previous_chance,
			"description": _aspect.stats.description
			})
	#else:
		#$".".hide()
