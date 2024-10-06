extends VBoxContainer

@onready var saver = %SaverUser

func _ready() -> void:
	update_after_save()
	Global.game_saved.connect(update_after_save)
	%UserName.text = saver.data['user_name']

func _physics_process(delta):
	if Input.is_action_just_pressed("menu"):
		get_tree().quit()

## Выход из игры
func _on_exit_button_down():
	print('exit')
	get_tree().quit()

## Поле битвы
func _on_battle_button_down() -> void:
	get_tree().change_scene_to_file("res://battle.tscn")

## Редактор умений
func _on_skills_button_down() -> void:
	get_tree().change_scene_to_file("res://skills_manager.tscn")

## Об игре
func _on_about_button_down() -> void:
	get_tree().change_scene_to_file("res://about.tscn")

## Переход на страницу "Отряд"
func _on_party_button_down() -> void:
	get_tree().change_scene_to_file("res://party.tscn")

## Сохранение игры по кнопке
func _on_save_button_down() -> void:
	Global.save_game()
	
func update_after_save():
	%Save_version.text = "v.%s-%s" % [Global.total_save_count, saver.save_count]

## Сохранение игры при обновлении поля "Имя"
func _on_text_edit_text_changed() -> void:
	saver.data.user_name = %UserName.text
	saver.save()

## Кнопка "Продолжить"
func _on_continue_button_down() -> void:
	saver.load_section()
	update_after_save()

## Кнопка "Удалить данные" - очищает сохранение игры
func _on_delete_save_button_down() -> void:
	Global.clear_save()

## Кнопка - напечатать сохранение игры в консоль
func _on_menu_button_button_down() -> void:
	print_debug(Global.config.encode_to_text(), saver.data)
