extends Node2D

## Компонент для сериализации и десирализации данных компонента для сохранения
class_name SerializerComponent

## Простые ключи для сериализации
@export var simple_keys: Array[String] = []
## Ключи для сериализации компонентов
@export var hard_serialize_keys: Array[String] = []
## Ключи для сериализации компонентов массивов
@export var array_serialize_keys: Array[String] = []

#func _ready() -> void:
	##owner.connect('serialize', serialize)
	#owner.connect('serialize', serialize)

## Сериализация компонента для последующего его сохранения
func serialize():
	var data = {}
	var owner_debug = owner
	
	print_debug('OWNER', owner , '      ' , data)
	for key in simple_keys:
		data[key] = owner[key]
	for key in hard_serialize_keys:
		if owner:
			data[key] = owner[key].serialize()
	for key in array_serialize_keys:
		#data[key] = owner[key].serialize()
		for array_item in owner[key]:
			if not key in data: 
				data[key] = []
			data[key].push_back(array_item.serialize())
			#data[key].push_back({})
		#if owner[key] and owner[key].has('serialize'):
			#data[key] = owner[key].serialize()
	print_debug("DATA SERI", data)
	return data

## Десириализация компонента
func deserialize(data: Dictionary):
	var owner_debug = owner
	for key in simple_keys:
		if data.has(key): 
			owner[key] = data[key]
	for key in hard_serialize_keys:
		if data.has(key) and data[key]:
			for object_key in data[key]:
				#owner[key][object_key] = data[key][object_key]
				#owner[key][object_key] = data[key][object_key]
				pass
	print_debug("DATA DESERI", data)
	return owner
