extends RichTextLabel
class_name History

var messages: Array[String] = []
	
func add_log(message: String, options):
	var prefix = ''
	#print(options)
	#if options.warn: 
		#prefix = '⚠️'
	messages.push_front(prefix + message)
	print_log()

func print_log():
	$'.'.text = '\n'.join(messages)
