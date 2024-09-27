extends Node

class_name Skill

@export var stats: SkillStats
@export var level: LevelComponent
@export var aspects: Array[PackedScene]

func test():
	print("It's just skill test in SkillStats.gd file")
	
func use():
	print('Skill use not implemented')
