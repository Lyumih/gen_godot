extends Node2D

## Компонент отвечает за умения у юнита
class_name SkillsComponent

## текущие умения
@export var skills: Array[Skill] = []

#func serialize(): return $SerializerComponent.serialize()
func serialize(): 
	return {"skills": [{
		"level": {"level": 13}
	}]}
func deserialize(data): return $SerializerComponent.deserialize(data)
