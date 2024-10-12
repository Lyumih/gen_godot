extends Node2D

## Компонент отвечает за умения у юнита
class_name SkillsComponent

## текущие умения
@export var skills: Array[Skill] = []

func serialize(): 
	return $SerializerComponent.serialize()
#func serialize(): 
	#var skills_serial = []
	#for skill in skills:
		#skills_serial.push_back(skill.serialize())
	#return {"skills": skills_serial}
func deserialize(data): 
	return $SerializerComponent.deserialize(data)
