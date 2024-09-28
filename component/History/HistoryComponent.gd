extends Node2D
class_name HistoryComponent

@export var messages: Array[String] = []
	
func add_log(message: String):
	messages.push_front(message)
#	# Сделать глобальную историю
