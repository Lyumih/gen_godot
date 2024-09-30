extends PanelContainer

class_name Player

signal health_changed(old_value, new_value)
signal health_depleted

signal init_skills(skills)

@export var STATS: StartingStats
@export var SKILLS: Array[Skill]

@export var speed_component: SpeedComponent
@export var active_component: ActiveComponent

var health: int = 100
var damage: int = 3
@export var unit_name:String = 'Аркадий2'

func _ready():
	init_skills.emit(SKILLS)
	%InfoPanel/Name.text = unit_name
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
	var info = 'Умений: ' + str(SKILLS.size())
	%InfoPanel/SkillInfo.text = info

func _on_actions_attacked():
	prints("DAMAGE", damage)
	take_damage(damage)


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed('click'):
		$TargetComponent.toggle_target()
