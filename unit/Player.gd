extends CharacterBody2D

class_name Player

signal health_changed(old_value, new_value)
signal health_depleted
signal hit

signal init_skills(skills)

@export var STATS: StartingStats
@export var SKILLS: Array[Skill]

@export var speed_component: SpeedComponent

@export var levels = {"attack": 1, "heal": 3}

var health: int = 100
var damage: int = 3
@export var unit_name:String = 'Аркадий2'

func _ready():
	init_skills.emit(SKILLS)
	$InfoPanel/Name.text = unit_name
	speed_component.max_speed = STATS.speed
	speed_component.speed = STATS.speed
	$Sprite2D.texture = STATS.texture
	$HelathBar.value = health
	$HelathBar.max_value = health
	info_text()
	info_skill_text()

func take_damage(amount): 
	var old_health = health
	health -= amount
	health_changed.emit(old_health, health)
	if health <= 0:
		health_depleted.emit()
	info_text()
		
## Выведение текста в панель информации по герою
func info_text():
	$HelathBar.value = health
	var info = 'Статистика\n' + str('Уровни:\n ', levels) + str('\nЗдоровье: ', health, '\nАтака: ', damage)
	$InfoPanel/Info.text = info
	
## Выведение текста в панель информации по умениям героя
func info_skill_text():
	var info = 'Умений: ' + str(SKILLS.size())
	$InfoPanel/SkillInfo.text = info

## Поднятие уровня в динамическом словаре
func level_up(stat_name: String, value_up: int = 1):
	if (stat_name in levels):
		levels[stat_name] = levels[stat_name] + value_up
	else:
		levels[stat_name] = value_up
	print('level up', levels, stat_name, levels[stat_name])
	info_text()
	
## Шансовое поднятие уровня. на 1 уровне = 100%, на 100 и больше уровне - 1%.
## Каждый уровень уменьшает шанс прокачки на 1% вполть до 1%
func level_up_chance(stat_name: String, value_up: int = 1):
	if (stat_name not in levels):
		return level_up(stat_name, value_up)
	var chance = randi()%100
	prints('fib 100', randi()%1000000)
	var min_chance = 100 - levels[stat_name] if levels[stat_name] <= 99 else 1
	prints('chance level up', stat_name, chance, min_chance, levels)
	if (chance <= min_chance):
		level_up(stat_name, value_up)
		prints('SUCCESS CHANCE', chance, min_chance, levels)

func _on_actions_attacked():
	prints("DAMAGE", damage)
	take_damage(damage)
	level_up_chance('attack')

func skill_heal(skill):
	prints("Heal", skill.heal)
	take_damage(- (STATS.heal + skill.heal))

func _on_actions_skill_activated(skill):
	prints('player _on_actions_skill_activated', skill.skill_name, skill)
	match skill.skill_name:
		'PowerAttack': take_damage(skill.damage * 2)
		'Heal': skill_heal(skill)
