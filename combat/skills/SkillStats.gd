extends Resource

class_name SkillStats

@export var skill_name: String = "Skill"
@export var description: String = "Skill description"

@export var tags: Array[String] = []

@export var power: int
@export var speed: int
@export var cd: int
@export var cost: int
@export var mana: int
@export var damage: int
@export var heal: int
@export var chance: int

func test():
	print('test')
