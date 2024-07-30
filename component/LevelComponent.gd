extends Node2D
class_name LevelComponent

@export var level = 1
@export var chance = 10

func upgrade_success(count: int = 1):
	level += count
	chance_update()
	
func level_reset(new_level: int = 1):
	level = new_level
	chance_update()
	
func chance_calculate():
	return 100 - level
	
func chance_update():
	chance = chance_calculate()
