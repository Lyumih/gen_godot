extends Node2D
class_name LevelComponent

## Текущий уровень компонента, от чего будет маштабироваться родительский компонент
@export var level = 1:
	set(new_level):
		level = new_level
		chance_update()
## Шанс (число), до которого должно выпасть, чтобы увеличился уровень
@export var chance = 99
## Логирование компонента прокачки
var logger = {
	"previous_chance": 0,
	"attemps": 0,
	"success": 0,
	"failed": 0
}

func _ready():
	chance_update()

## 100% увеличивает уровень на 1 или больше
func upgrade_success(count: int = 1):
	level += count
	#chance_update()

## С шансом увеличивает уровень. Основная механика
func upgrade_chance(count: int = 1):
	var random_chance = randi()%100
	logger.previous_chance = random_chance
	logger.attemps = logger.attemps + 1
	if (random_chance <= chance):
		logger.success = logger.success + 1
		upgrade_success(count)
	else:
		logger.failed = logger.failed + 1
	print_logger()
	
## Устанавливает уровень на 1 или выбранный
func level_reset(new_level: int = 1):
	level = new_level
	#chance_update()
	
## Высчитывает миниальный шанс для апгрейда уровня. Свыше 99 уровня шанс составляет 1%
func chance_calculate():
	return 100 - level if level <= 99 else 1
	
## Вспомогательная функция пересчёта шанса после изменения уровня
func chance_update():
	chance = chance_calculate()

## Логгер для дебага
func print_logger():
	prints({"level": level, "chance": chance}, logger )
	
## Мультиплеер уровня
func level_multiplier():
	return 1 + level * 0.01
