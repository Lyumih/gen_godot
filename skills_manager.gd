extends Node2D

@export var skill: Skill

@export var aspects: Array[Aspect] = []

var format_skill_info = "Имя: {name}
Теги: {tags}
Описание: {description}
Уровень: {level}
Шанс прокачки: {chance}%({previous_chance}) при использовании
Скорость: {speed}
Перезарядка: {cd}"

func _ready():
	update_info()

func update_info():
	$Manager/SkillInfoPanel/SkillInfo.text = format_skill_info.format({
		"name": skill.stats.skill_name,
		"tags": str(skill.stats.tags),
		"description": skill.stats.description,
		"level": skill.level.level,
		"chance": skill.level.chance,
		"previous_chance": skill.level.logger.previous_chance,
		"speed": skill.stats.speed,
		"cd": skill.stats.cd
		})

func _on_level_up_button_down():
	skill.level.upgrade_chance(1)
	update_info()
