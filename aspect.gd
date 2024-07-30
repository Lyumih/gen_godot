extends HBoxContainer
@export var aspect: PackedScene

var aspect_info_format = '{name}. 
Ур. {level} ({level_chance}% шанс на прокачку после победы)
{description}'

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
			"level_chance": _aspect.level.chance,
			"description": _aspect.stats.description
			})
	#else:
		#$".".hide()
