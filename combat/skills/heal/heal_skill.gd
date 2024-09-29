extends Skill
class_name HealSkill

func use_logic() -> bool:
	if targets().size() == 1:
		first_target().take_damage(-calc_values().heal)
		return true
	return false
	
func hint():
	var heal = calc_values().heal
	return 'Исцеляет на %s 💖' % str(heal)
	
func calc_values():
	var heal_all_source = stats.heal
	if source():
		heal_all_source += source().STATS.heal
	return {
		"heal": floor(heal_all_source * level.level_multiplier())
	}
