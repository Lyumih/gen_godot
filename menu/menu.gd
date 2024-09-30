extends HBoxContainer

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
