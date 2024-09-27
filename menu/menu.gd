extends HBoxContainer

func _physics_process(delta):
	if Input.is_action_just_pressed("menu"):
		get_tree().quit()
		#visible = !visible


func _on_exit_button_down():
	print('exit')
	get_tree().quit()
	pass # Replace with function body.


func _on_battle_button_down() -> void:
	get_tree().change_scene_to_file("res://battle.tscn")
	pass # Replace with function body.


func _on_skills_button_down() -> void:
	get_tree().change_scene_to_file("res://skills_manager.tscn")
	pass # Replace with function body.
