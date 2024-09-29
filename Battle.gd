extends Node2D

## Поиск нового врага
func _on_game_actions_search_enemy():
	var enemy = preload("res://unit/player.tscn").instantiate()
	enemy.STATS = load("res://combat/bot/Mouse.tres")
	enemy.position = $UnitsContainer.position
	$History.add_log('Поиск нового врага')
	self.add_child(enemy)
	#$Enemy.queue_free()

## Сбежать из битвы и полечиться
func _on_game_actions_leave_battle():
	print('leave')
	get_tree().call_group('enemies', 'queue_free')
	$History.add_log('Сбежать и полечиться')
	pass # Replace with function body.

## Атаковать персонажем
func _on_unit_actions_attacked():
	var enemies = get_tree().get_nodes_in_group('targets')
	print('_on_unit_actions_attacked', enemies)
	if enemies.size() > 0:
		enemies[0].get_parent().take_damage(1)
		$History.add_log('Атака ')
		print()
	next_turn()

## Активировать умение
func _on_unit_actions_skill_activated(skill: Skill):
	print('skill', skill)
	var enemies = get_tree().get_nodes_in_group('enemies')
	skill.use()
	$History.add_log('Использовано умение ' + str(skill.stats.skill_name) + ' на ' + str(skill.first_target().unit_name))
	next_turn()

## Пропустить ход
func _on_game_actions_skip_turn():
	$History.add_log('Пропуск хода')
	next_turn()
	
func next_turn():
	$TurnComponent.next_turn()
	$ActionsPanel/SpeedPanel.turn = $TurnComponent.turn
