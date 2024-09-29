extends Panel

var items = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	if Input.is_action_just_pressed('ui_inventory'):
		visible = !visible


func _on_item_list_item_activated(index: int) -> void:
	print(index)
	use_item(index)
	%ItemList.remove_item(index)
	pass # Replace with function body.

func use_item(index: int):
	var player = get_tree().get_first_node_in_group('active') as Player
	player.take_damage(5)
	%HistoryComponent.add_log("Использовано %s на %s" % [%ItemList.get_item_text(index), player.unit_name])
	
