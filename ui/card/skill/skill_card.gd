extends Container

@export var skill: Skill
	
func update_skill(new_skill: Skill):
	skill = new_skill
	if skill:
		%Skill.show()
		%Skill.icon = skill.stats.icon
		%Skill.text = str(skill.stats.skill_name) + '\nУр:' + str(skill.level.level) + '. ' + str(skill.level.logger.previous_chance) + '%' + '\n' + str(skill.hint())
	else:
		%Skill.hide()
