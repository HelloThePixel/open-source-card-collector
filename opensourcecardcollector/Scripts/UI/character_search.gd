extends TextEdit

@export var Gallery : Control

func _on_text_changed() -> void:
	Gallery.Filter(string_array(text))
	pass # Replace with function body.

func string_array(basetext : String) -> PackedStringArray:
	var array : PackedStringArray = basetext.split(",")
	for i in array:
		i = i.to_lower()
		i.strip_edges(true, true)
	return array
