extends PanelContainer

class_name Player

signal health_changed(old_value, new_value)
signal health_depleted

@export var STATS: StartingStats
@export var SKILLS: Array[Skill]

@export var speed_component: SpeedComponent
@export var active_component: ActiveComponent
@export var level_component: LevelComponent

## Простые ключи для сериализации
var simple_keys = ['upgrades', 'unit_name', 'health', 'damage', 'upgrades_list']

var health: int = 100
var damage: int = 3
@export var unit_name:String = 'Юнит'

## Переменная для хранения улучшения характеристик самого персонажа. Массив {index: upgrade_id}
var upgrades = {}
## Все доступные апгрейды для персонажа
var upgrades_list = []

var table_width = 15
var table_height = 15
var table_size = table_width * table_height

func _ready():
	%InfoPanel/Name.text = "%s. Ур. %s" % [unit_name, level_component.level]
	speed_component.max_speed = STATS.speed
	speed_component.speed = STATS.speed
	%Sprite2D.texture = STATS.texture
	%HelathBar.value = health
	%HelathBar.max_value = health
	info_text()
	info_skill_text()
	
func set_active(active: bool):
	active_component.set_active(active)

func take_damage(amount): 
	var old_health = health
	health -= amount
	health_changed.emit(old_health, health)
	if health <= 0:
		health_depleted.emit()
	info_text()
		
## Выведение текста в панель информации по герою
func info_text():
	%HelathBar.value = health
	var info = "❤️%s\n⚕️%s 💪%s" % [health, STATS.heal, STATS.damage]
	%InfoPanel/Info.text = info
	
## Выведение текста в панель информации по умениям героя
func info_skill_text():
	var info = 'Умений: %s\nРазвитий: %s' % [SKILLS.size(), upgrades.size()]
	%InfoPanel/SkillInfo.text = info

func _on_actions_attacked():
	prints("DAMAGE", damage)
	take_damage(damage)


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed('click'):
		$TargetComponent.toggle_target()

func serialize():
	var data = {}
	for key in simple_keys:
		data[key] = self[key]
	return data

func deserialize(data: Dictionary):
	for key in simple_keys:
		if data.has(key): 
			self[key] = data[key]
	return self
	
static func deserialize_scene(data: Dictionary):
	var scene = preload("res://unit/player.tscn")
	var unit: Player = scene.instantiate()
	return unit.deserialize(data)
