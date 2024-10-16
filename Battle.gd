extends Control

@onready var party_saver = $PartySaver

## Загрузка отряда для битвы
func _ready() -> void:
	load_party()
	
## Загрузка отряда из сохранения
func load_party():
	print_debug('load_party', party_saver.data, party_saver.data.units)
	for data_unit in party_saver.data.units:
		var scene = preload("res://unit/player.tscn")
		var new_unit: Player = scene.instantiate()
		%PlayersContainer.add_child(new_unit)
		new_unit.deserialize(data_unit)

## Поиск нового врага
func _on_game_actions_search_enemy():
	var enemy = preload("res://unit/player.tscn").instantiate()
	enemy.STATS = load("res://combat/bot/Mouse.tres")
	enemy.unit_name = enemy.STATS.job_name
	enemy.add_to_group('enemies')
	enemy.position = $UnitsContainer.position
	%HistoryComponent.add_log('Поиск нового врага')
	%EnemyContainer.add_child(enemy)

## Сбежать из битвы и полечиться
func _on_game_actions_leave_battle():
	print('leave')
	get_tree().call_group('enemies', 'queue_free')
	for player in get_tree().get_nodes_in_group('players') as Array[Player]:
		player.health = 100
	%HistoryComponent.add_log('Сбежать и полечиться')

## Атаковать персонажем
func _on_unit_actions_attacked():
	var enemies = get_tree().get_nodes_in_group('targets')
	print('_on_unit_actions_attacked', enemies)
	if enemies.size() > 0:
		#enemies[0].get_parent().take_damage(1)
		enemies[0].take_damage(1)
		%HistoryComponent.add_log('Атака ')
		print()
	next_turn()

## Активировать умение
func _on_unit_actions_skill_activated(skill: Skill):
	if skill.use():
		next_turn()

## Пропустить ход
func _on_game_actions_skip_turn():
	%HistoryComponent.add_log('Пропуск хода')
	next_turn()

## Следующий ход
func next_turn():
	$TurnComponent.next_turn()
	$ActionsPanel/SpeedPanel.turn = $TurnComponent.turn
