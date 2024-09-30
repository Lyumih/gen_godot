extends Node2D

func _ready() -> void:
	EventBus.target_changed.connect(update_skill_list)
	print('_ready')

func update_skill_list():
	for child in %SkillsContainer.get_children(): child.queue_free()
	var player = get_tree().get_first_node_in_group(Global.GROUPS.TARGETS) as Player
	print('update_skill_list', player)
	if player and player.SKILLS:
		for skill in player.SKILLS as Array[Skill]:
			var skillCard = load("res://ui/card/skill/SkillCard.tscn").instantiate()
			%SkillsContainer.add_child(skillCard)
			skillCard.update_skill(skill)
