extends Skill
class_name HealSkill

func use_logic():
	if targets().size() == 1:
		first_target().take_damage(-calc_values().heal)
	history.add_log('TEST TEST TEST')
	
func hint():
	var heal = calc_values().heal
	return 'Исцеляет на %s здоровья' % str(heal)
	
func calc_values():
	var heal_all_source = stats.heal + source().STATS.heal
	return {
		"heal": floor(heal_all_source * level.level_multiplier())
	}
