extends Skill
class_name PowerAttack

func use():
	print('Skill use PowerAttack')
	print('skill targets', targets())
	if targets().size() == 1:
		first_target().take_damage(calc_values().attack)
	history.add_log('TEST TEST TEST')
	
func hint():
	#return 'Бьёт на 10 (10 + 1% за ур.) + Атака здоровья'
	var attack = calc_values().attack
	return 'Бьёт на %s здоровья' % str(attack)

func calc_values():
	var source = source()
	var damage = 0
	#if source():
		#damage = source().damage
	return {
		"attack": stats.damage + floor(stats.damage * level.level / 100) + damage
	}
