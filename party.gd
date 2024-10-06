extends Control

var table_width = 15
var table_height = 15
var table_size = table_width * table_height

var player: Player
var upgrades = ["❤️2", "❤️10", "💪1", "💪4", "⚕2", "⚕6", "", "👟1"]
var all_upgrades = []

@onready var party_saver = %PartySaver

func _ready() -> void:
	load_party()
	EventBus.target_changed.connect(change_target)
	change_target()
	%TableUpgrades.columns = table_width
	init_all_upgrades()
	init_unit_upgrades()
	
## Загрузка отряда из сохранения
func load_party():
	print_debug('load_party', party_saver.data, party_saver.data.units)
	for unit in party_saver.data.units:
		%HeroesContainer.add_child(Player.deserialize_scene(unit))
		print_debug(unit)

## Добавление нового героя в группу
func _on_add_hero_button_down() -> void:
	print_debug('add hero')
	var scene = preload("res://unit/player.tscn")
	var new_hero: Player = scene.instantiate()
	new_hero.unit_name = str(randi())
	party_saver.data.units.push_front(new_hero.serialize())
	party_saver.save()
	%HeroesContainer.add_child(new_hero)

## Наполнение таблицы случайными улучшениями.
func init_all_upgrades():
	for index in table_size:
		all_upgrades.push_front(upgrades.pick_random())
	
## отлавливается событие смены персонажа
func change_target():
	player = get_tree().get_first_node_in_group(Global.GROUPS.TARGETS) as Player
	if player:
		%TabContainer.show()
	else: 
		%TabContainer.hide()
	update_skill_list()
	update_player_label()
	
## Обновляет список умений у текущего игрока
func update_skill_list():
	for child in %SkillsContainer.get_children(): child.queue_free()
	print('update_skill_list', player)
	if player and player.SKILLS:
		for skill in player.SKILLS as Array[Skill]:
			var skillCard = load("res://ui/card/skill/SkillCard.tscn").instantiate()
			%SkillsContainer.add_child(skillCard)
			skillCard.update_skill(skill)

## Создание таблицы улучшений персонажа
func init_unit_upgrades():
	#var size = table_width * table_height
	#for item_index in size:
	for item_index in table_size:
		var cell = Button.new()
		cell.text = all_upgrades[item_index]
		cell.custom_minimum_size = Vector2(48, 48)
		cell.connect('button_down', upgrade_player_cell_click.bind(item_index))
		%TableUpgrades.add_child(cell)
		upgrade_cells()

## обновлене лейбла ячеек
func upgrade_cells():
	if player:
		for item_index in table_size:
			var cell = %TableUpgrades.get_child(item_index) as Button
			if player.upgrades.has(item_index):
				cell.text = player.upgrades[item_index]
				cell.modulate.b = 200

## Нажатие на конкретное улучшение персонажа
func upgrade_player_cell_click(index):
	if player.upgrades.has(index):
		return
	if player.level_component.level > player.upgrades.size():
		print(index, player, player.upgrades)
		#player.all_upgrades = all_upgrades
		player.upgrades[index] = all_upgrades[index]
		party_saver.save()
		update_player_label()
		upgrade_cells()
	
## Обеовление лейбла с описанием характеристик
func update_player_label():
	if player:
		%PlayerUpgradesLabel.text = "Улучшений: %s. Уровень: %s\n%s" % [player.upgrades.size(), player.level_component.level, "\n".join(player.upgrades.values())]

	
