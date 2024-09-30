extends Node2D
class_name SpeedComponent

## Максимальная скорость юнита. Если меньше 0 при тике, то возвращается к этой скорости
@export var max_speed := 3
## Локальная скорость юнита
@export var speed := 2:
	set(new_speed):
		speed = new_speed
		update_hint()

func _ready():
	speed = max_speed
	
func update_hint():
	$SpeedHint.text = "👟: %s(%s)" % [speed, max_speed]

## функция тика скорости юнита. Если скорость доходит до 0, то ходит юнит и нужно остановить другие тики
func tick():
	if speed < 1:
		speed = max_speed
	else:
		speed -= 1
