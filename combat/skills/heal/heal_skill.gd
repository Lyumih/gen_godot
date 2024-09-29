extends Skill
class_name HealSkill

func use_logic() -> bool:
	if targets().size() == 1:
		first_target().take_damage(-calc_values().heal)
		history().add_log("🪄%s: %s %s %s" % [stats.skill_name, source().unit_name, hint(), first_target().unit_name])
		return true
	history().add_log("Неправильное количество целей", {"warn": false})
	return false
	
func hint():
	var heal = calc_values().heal
	return 'Исцеляет на %s 💖' % str(heal)
	
func calc_values():
	var heal_all_source = stats.heal + source().STATS.heal
	return {
		"heal": floor(heal_all_source * level.level_multiplier())
	}
