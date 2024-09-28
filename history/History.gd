extends RichTextLabel

@export var messages: Array[String] = []
	
func add_log(message: String):
	messages.push_front(message)
	print_log()

func print_log():
	$'.'.text = '\n'.join(messages)
