@tool
class_name TestItem
extends Resource

@export var name: String
@export var color: Color

func to_rich_string() -> String:
	return "[%s;b]%s[]" % [color, name]
