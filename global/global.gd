extends Node

## Сигнал, что игра была сохранена
signal game_saved
## Сигнал, что игра была загружена
signal game_loaded

## Файл-конфиг с сохранением игры
var config: ConfigFile = ConfigFile.new();
## Путь к файлу для сохраненя игры.
var path_to_save_file := "user://save-gen-godot.cfg"
## Секция для сохранения игры
var section_name := "game"

## имя пользователя
var user_name: String
## количество сохранение
var saves = 0

## Константа с именами групп
const GROUPS = {
	"TARGETS": "targets", 
	"ACTIVE": "active"
}

## Загружаем игру при старте
func _ready():
	print('Global _ready')
	var isLoaded = config.load(path_to_save_file)
	print("Loaded: " + error_string(isLoaded))
	load_game()

## Сохранение всего состояния игры
func save_game():
	saves += 1
	config.set_value(section_name, "user_name", user_name)
	config.set_value(section_name, "saves", saves)

	config.save(path_to_save_file)
	game_saved.emit()
	print('Save game', config.encode_to_text())

## Загрузка всего состояния игры
func load_game():
	print("LOAD GAME before", config.encode_to_text())
	user_name = config.get_value(section_name, "user_name", "Бобик")
	saves = config.get_value(section_name, "saves", saves)
	game_loaded.emit()
	print('LOAD GAME after',  config.encode_to_text(), config)
