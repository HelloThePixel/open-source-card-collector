extends TextEdit

@export var Gallery : Control

func _ready() -> void:
	text = SaveManager.LoadBlockedTags()

func GetTags() -> PackedStringArray:
	return string_array(text)
	
func string_array(basetext : String) -> PackedStringArray:
	var array : PackedStringArray = basetext.split(",")
	for i in array:
		i = i.to_lower()
		i.strip_edges(true, true)
	return array


func _on_text_changed() -> void:
	Gallery.TagBlocker(GetTags())
	SaveManager.SaveBlockedTags(text)
	pass # Replace with function body.
