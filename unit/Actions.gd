extends Control

## Использование кнопки атака
signal attacked
## Использование умения N
signal skill_activated(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.next_turn.connect(next_turn_actions)
	update_skills_panel()
		
func update_skills_panel():
	for child in $SkillContainer.get_children():
		child.queue_free()
	var player = get_tree().get_first_node_in_group('active') as Player 
	print("\nSKILL _ready", player, ' SIZE:', get_tree().get_node_count_in_group('active'), get_tree().get_nodes_in_group('active'))
	if player == null:
		return
	$UnitName.text = player.unit_name
	print(player.SKILLS)
	for skill in player.SKILLS:
		var button_skill = Button.new()
		$SkillContainer.add_child(button_skill)
		button_skill.text = str(skill.stats.skill_name) + '\nУр:' + str(skill.level.level) + '. ' + str(skill.level.logger.previous_chance) + '%' + '\n' + str(skill.hint())
		button_skill.icon = skill.stats.icon
		button_skill.add_theme_constant_override('icon_max_width', 64)
		button_skill.pressed.connect(self.clickSkill.bind(skill))
		print("SKILL" + str(skill))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#update_skills_panel()
	var units = get_tree().get_nodes_in_group('targets')
	$HBoxContainer/Attack.disabled = units.size() == 0

func clickSkill(skill):
	print('worked skill_activated', skill)
	skill_activated.emit(skill)
	update_skills_panel()

func _on_button_button_down():
	$TurnComponent.next_turn()
	attacked.emit()

## Использование умения
func _on_skill_button_down():
	#skill_activated.emit(skills)
	pass


func _on_attack_mouse_entered():
	$InfoContainer.show()
	$InfoContainer/Info.text = 'Атака'


func _on_attack_mouse_exited():
	$InfoContainer.hide()

func next_turn_actions():
	update_skills_panel()
	print('NEXT TURN next_turn_actions')
