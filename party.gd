extends Control

## Текущий выбранный игрок
var player: Player

@onready var party_saver = %PartySaver

func _ready() -> void:
	load_party()
	EventBus.target_changed.connect(change_target)
	fill_all_skills()
	#change_target()
	
## Загрузка отряда из сохранения
func load_party():
	print_debug('load_party', party_saver.data, party_saver.data.units)
	for data_unit in party_saver.data.units:
		var scene = preload("res://unit/player.tscn")
		var new_unit: Player = scene.instantiate()
		%HeroesContainer.add_child(new_unit)
		new_unit.deserialize(data_unit)
		
## Добавить все умения в список умений
func fill_all_skills():
	var skills: Array[Skill] = [$HealSkill, $PowerAttack]
	for skill in skills:
		var skillCard = load("res://ui/card/skill/SkillCard.tscn").instantiate() as SkillCard
		skillCard.update_skill(skill)
		skillCard.skill_clicked.connect(add_skill_to_player)
		%AllSkills.add_child(skillCard)
		
## Добавить умение персонажу
func add_skill_to_player(skill: Skill):
	if player:
		player.skills_component.skills.push_back(skill)
		print_debug("ADD SKILL", skill, player.skills_component.skills)
		update_skill_list()
		save_current_player()
	
## Обновляет список умений у текущего игрока
func update_skill_list():
	for child in %SkillsContainer.get_children(): child.queue_free()
	if player and player.skills_component:
		for skill in player.skills_component.skills:
			var skillCard = preload("res://ui/card/skill/SkillCard.tscn").instantiate()
			%SkillsContainer.add_child(skillCard)
			skillCard.update_skill(skill)

## Добавление нового героя в группу
func _on_add_hero_button_down() -> void:
	var scene = preload("res://unit/player.tscn")
	var new_hero: Player = scene.instantiate()
	new_hero.unit_name = str(randi_range(1, 1000))
	%HeroesContainer.add_child(new_hero)
	party_saver.data.units.push_back(new_hero.serialize())
	party_saver.save()
	
## Удаление игрока
func remove_player():
	%HeroesContainer.get_child(0).queue_free()
	
## отлавливается событие смены персонажа
func change_target():
	player = get_tree().get_first_node_in_group(Global.GROUPS.TARGETS) as Player
	if player:
		%TabContainer.show()
		%TableUpgrades.columns = player.mastery_component.table_width
		update_skill_list()
		update_player_label()
		init_unit_upgrades()
	else: 
		%TabContainer.hide()
		for child in %TableUpgrades.get_children():
			child.queue_free()


## Создание таблицы улучшений персонажа
func init_unit_upgrades():
	if not player.mastery_component:
		return
	for item_index in player.mastery_component.table_size:
		var cell = Button.new()
		cell.text = player.mastery_component.all_upgrades[item_index]
		cell.custom_minimum_size = Vector2(48, 48)
		cell.connect('button_down', upgrade_player_cell_click.bind(item_index))
		%TableUpgrades.add_child(cell)
		upgrade_cells()

## обновлене лейбла ячеек
func upgrade_cells():
	if player:
		for item_index in %TableUpgrades.get_child_count():
			if player.mastery_component.upgrades.has(item_index):
				var cell = %TableUpgrades.get_child(item_index) as Button
				cell.text = player.mastery_component.upgrades[item_index]
				cell.modulate.b = 200

## Нажатие на конкретное улучшение персонажа
func upgrade_player_cell_click(index):
	player.mastery_component.mastery_upgrade(index)
	save_current_player()
	upgrade_cells()
	
## Сохранение текущего персонажа
func save_current_player():
	for unit_index in party_saver.data.units.size():
		if party_saver.data.units[unit_index].unit_name == player.unit_name:
			party_saver.data.units[unit_index] = player.serialize()
			party_saver.save()
	
## Обеовление лейбла с описанием характеристик
func update_player_label():
	if player:
		%PlayerUpgradesLabel.text = "Улучшений: %s. Уровень: %s\n%s" % [player.mastery_component.upgrades.size(), player.level_component.level, "\n".join(player.mastery_component.upgrades.values())]

## Удаление текущего игрока
func _on_remove_button_down() -> void:
	party_saver.data.units.remove_at(0)
	player.queue_free()
	party_saver.save()

## Добавление случайных характеристик
func _on_random_stats_button_down() -> void:
	if player:
		player.health = randi_range(30, 130)
		player.STATS.damage = randi_range(1, 10)
		player.STATS.heal = randi_range(10, 30)
		player.level_component.level = randi_range(1, 50)
		save_current_player()
