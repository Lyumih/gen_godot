extends Container

class_name SkillCard

## Сигнал - Нажатие на умение
signal skill_clicked(skill)

@export var skill: Skill

## Добавление скила в карточку	
func update_skill(new_skill: Skill):
	skill = new_skill
	if skill:
		%Skill.show()
		if skill.stats:
			%Skill.icon = skill.stats.icon
			%Skill.text = str(skill.stats.skill_name) + '\nУр:' + str(skill.level.level) + '. ' + str(skill.level.logger.previous_chance) + '%' + '\n' + str(skill.hint())
	else:
		%Skill.hide()

## Сигнал: Нажатие на умение
func _on_skill_button_down() -> void:
	skill_clicked.emit(skill)
