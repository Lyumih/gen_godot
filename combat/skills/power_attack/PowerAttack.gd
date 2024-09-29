extends Skill
class_name PowerAttack

## Умение наносит больше урона на Х, чем обычная атака
func use_logic() -> bool:
	if targets().size() == 1:
		first_target().take_damage(calc_values().attack)
		return true
	return false

func hint():
	return 'Бьёт на %s здоровья' % str( calc_values().attack)

func calc_values():
	var damage_all_source = stats.damage 
	if source():
		damage_all_source += source().STATS.damage
	return {
		"attack": floor(damage_all_source * level.level_multiplier())
	}
