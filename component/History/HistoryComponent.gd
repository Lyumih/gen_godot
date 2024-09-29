extends Node2D
class_name HistoryComponent
	
## Добавление логов в глобальную историю
func add_log(message: String, options = {}):
	var history = get_history()
	if history:
		get_history().add_log(message, options)
	else:
		printerr('History not found. HistoryComponent')

## Нахождение отображения истории в проекте
func get_history():
	return get_tree().get_first_node_in_group('history') as History
#	# Сделать глобальную историю
