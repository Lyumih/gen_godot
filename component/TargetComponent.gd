extends Node2D
class_name TargetComponent

@export var collisionObject2D: CollisionObject2D
@export var sprite2D: Sprite2D

## isTarget - отвечает за то, в таргете сейчас объект или нет
@export var isTarget := false:
	set(new_value):
		isTarget = new_value
		update()
		
var TARGETS_GROUPS = 'targets'

## Логика обновления таргета
func update():
	if isTarget:
		$'.'.add_to_group(TARGETS_GROUPS)
		collisionObject2D.skew = 0.2
	else:
		$'.'.remove_from_group(TARGETS_GROUPS)
		collisionObject2D.skew = 0
	$Label.text = 'Таргет: ' + str(isTarget)

## Коннект переключения мыши к компоненту
func _ready():
	if collisionObject2D:
		collisionObject2D.input_event.connect(toggle_target.bind())
		update()

## По нажатию мышки переключить таргет - отлавливание сигнала
func toggle_target(viewport: Node, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton and event.pressed:
		isTarget = !isTarget
	
## Установить значение isTarget из метода групп. Можно сбросить все разом	
func set_target(value: bool):
	isTarget = value
