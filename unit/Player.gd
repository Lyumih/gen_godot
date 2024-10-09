extends PanelContainer

class_name Player

signal health_changed(old_value, new_value)
signal health_depleted

var health: int = 100:
	set(value):
		health = value
		update_unit_info()

## Имя юнита. Нужно переделать на компонент
@export var unit_name:String = 'Юнит'

## Начальные статы юнита
@export var STATS: StartingStats

## Умения юнита
@export var SKILLS: Array[Skill]

## Компоненты юнита
@export var speed_component: SpeedComponent
@export var active_component: ActiveComponent
@onready var level_component: LevelComponent = $LevelComponent
@onready var mastery_component: MasteryComponent = $MasteryComponent
@onready var skills_component: SkillsComponent = $SkillsComponent

## Инициализация статов юнита и информации о нём
func _ready():
	speed_component.max_speed = STATS.speed
	speed_component.speed = STATS.speed
	%Sprite2D.texture = STATS.texture
	update_unit_info()
	
## Обновление информации о герое
func update_unit_info():
	%InfoPanel/Name.text = "%s. Ур. %s" % [unit_name, level_component.level]
	%HelathBar.max_value = health
	%HelathBar.value = health
	%InfoPanel/Info.text = "❤️%s\n⚕️%s 💪%s" % [health, STATS.heal, STATS.damage]
	%InfoPanel/SkillInfo.text = 'Умений: %s\nРазвитий: %s' % [skills_component.skills.size(), mastery_component.upgrades.size()]
	
func set_active(active: bool):
	active_component.set_active(active)

func take_damage(amount): 
	var old_health = health
	health -= amount
	health_changed.emit(old_health, health)
	if health <= 0:
		health_depleted.emit()
	update_unit_info()
		
func _on_actions_attacked():
	prints("DAMAGE", STATS.damage)
	take_damage(STATS.damage)

## Смена цели по клику персонажа
func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed('click'):
		$TargetComponent.toggle_target()
		
func serialize(): return $SerializerComponent.serialize()
func deserialize(data): return $SerializerComponent.deserialize(data)

## Сигнал: мастерство было улучшено у персонажа
func _on_mastery_component_mastery_upgraded() -> void:
	update_unit_info()

## Сигнал - когда повышается уровень
func _on_level_component_level_upgraded() -> void:
	update_unit_info()
