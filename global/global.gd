extends Node

## Сигнал, что игра была сохранена
signal game_saved
## Сигнал, что игра была загружена
signal game_loaded

## Файл-конфиг с сохранением игры
var config: ConfigFile = ConfigFile.new();
## Путь к файлу для сохраненя игры.
var path_to_save_file := "user://save-gen-godot.cfg"

## количество сохранение
@onready var total_save_count = 0

## Константа с именами групп
const GROUPS := {
	"TARGETS": "targets", 
	"ACTIVE": "active"
}

func _ready() -> void:
	init_load_game()
	
## начальная загрузка игры
func init_load_game():
	var loaded_error = config.load(path_to_save_file)
	if loaded_error: 
		printerr(loaded_error, error_string(loaded_error))
	total_save_count = config.get_value("HACKER", "total_save_count", 0)

## Сохранение всего состояния игры
func save_game():
	total_save_count += 1
	config.set_value("HACKER", "total_save_count", total_save_count)

	config.save(path_to_save_file)
	game_saved.emit()
	#print('Save game', config.encode_to_text())

## Загрузка всего состояния игры
func load_game():
	total_save_count = config.get_value("HACKER", "total_save_count", 0)
	game_loaded.emit()

## Полностью очищает сохранение игры
func clear_save():
	config.clear()
	total_save_count = 0
	save_game()
	print_debug("DELETED", config.encode_to_text())
