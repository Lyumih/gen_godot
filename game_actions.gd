extends HBoxContainer

signal search_enemy
signal leave_battle
signal skip_turn

func _on_search_button_down():
	search_enemy.emit()
	pass # Replace with function body.


func _on_leave_button_down():
	leave_battle.emit()
	pass # Replace with function body.


func _on_skip_button_down():
	skip_turn.emit()
	pass # Replace with function body.
