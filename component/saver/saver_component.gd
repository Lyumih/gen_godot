extends Node2D

class_name SaverComponent

# Строковое значение секции сохранения игры
@export_enum("ERROR_SECTION_KEY", "GAME", "USER", "PARTY") var section = "ERROR_SECTION_KEY"

## Объект с данными для перезаписи в компоненте.
@export var data = {}

## Сохраняет или нет текущую итерацию секции. Удобно сохранить данные и каждый раз заново их выгружать
@export var need_save := true
## Печатать в консоль для дебага. true - нужен вывод печати
@export var NEED_PRINT := false

@onready var save_count = Global.config.get_value(section, 'save_count', 0)

## Начальная загрузка данных
func _ready() -> void:
	load_section()
	
## Сохранение данных
func save():
	if need_save:
		for key in data:
			Global.config.set_value(section, key, data[key])
		update_save_version()
		Global.save_game()
		
## Загрузка данных для секции
func load_section():
	var keys = data.keys()
	for key in keys:
		if NEED_PRINT: print_debug(key, data, data[key],  Global.config.get_value(section, key))
		data[key] = Global.config.get_value(section, key, data[key])
	if NEED_PRINT: print_debug(data, Global.config.encode_to_text())
	Global.game_loaded.emit()
	
## Сохранение версии блока игры
func update_save_version():
	save_count += 1
	var total_save_count = Global.config.get_value('HACKER', 'total_save_count', 0)
	Global.config.set_value(section, "save_count", save_count)
	Global.config.set_value(section, "last_total_save_count", total_save_count + 1)
	
## Todo: Пробегает по родительским компонентам до тех пор, пока не найдёт, где можно себя сохранить
func parent_save():
	pass
