extends RichTextLabel

@export var messages: Array[String] = []

func _ready():
	print_log()
	
func add_log(message: String):
	messages.push_front(message)
	print_log()

func print_log():
	$HistoryList.text = '\n'.join(messages)
