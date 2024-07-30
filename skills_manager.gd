extends Node2D

@export var skill: Skill

@export var aspects: Array[Aspect] = []

var format_skill_info = "Имя: {name}
Теги: {tags}
Описание: {description}
Уровень: {level} ({chance}% шанс прокачать при использовании)
Скорость: {speed}
Перезарядка: {cd}"

func _ready():
	skill.level.upgrade_success()
	$Manager/SkillInfoPanel/SkillInfo.text = format_skill_info.format({
		"name": skill.stats.skill_name,
		"tags": str(skill.stats.tags),
		"description": skill.stats.description,
		"level": skill.level.level,
		"chance": skill.level.chance,
		"speed": skill.stats.speed,
		"cd": skill.stats.cd
		})

