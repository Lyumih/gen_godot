extends Node2D
class_name TargetComponent

## isTarget - отвечает за то, в таргете сейчас объект или нет
@export var isTarget := false:
	set(new_value):
		isTarget = new_value
		update()
	
## Имя группы таргета	
var TARGETS_GROUPS = Global.GROUPS.TARGETS

## Логика обновления таргета
func update():
	print('update')
	if isTarget:
		owner.add_to_group(TARGETS_GROUPS)
	else:
		owner.remove_from_group(TARGETS_GROUPS)
	$TargetHint.visible = isTarget
	EventBus.target_changed.emit()

## Коннект переключения мыши к компоненту
func _ready():
	update()

## По нажатию мышки переключить таргет - отлавливание сигнала
func toggle_target():
	print('toggle_target')
	isTarget = !isTarget
	
## Установить значение isTarget из метода групп. Можно сбросить все разом	
func set_target(value: bool):
	isTarget = value
