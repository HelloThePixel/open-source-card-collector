extends Node

var cardDirectoryPath : String
var blockedTags : String

var saveDataStorage = "user://OSCC.save"

func SaveCardDirectoryPath(path : String):
	cardDirectoryPath = path
	Save()
	pass

func SaveBlockedTags(tags : String):
	blockedTags = tags
	Save()

func Save():
	var save_info = {
		"cardDirectoryPath" : cardDirectoryPath,
		"blockedTags" : blockedTags
	}
	var save_file = FileAccess.open(saveDataStorage, FileAccess.WRITE)
	var json_string = JSON.stringify(save_info)
	save_file.store_line(json_string)
	pass

func LoadSaveCardDirectoryPath() -> String:
	var path = ""
	var save_data = Load()
	if save_data.has("cardDirectoryPath"):
		path = save_data["cardDirectoryPath"]
	return path

func LoadBlockedTags() -> String:
	var path : String
	var save_data = Load()
	if save_data.has("blockedTags"):
		path = save_data["blockedTags"]
	return path

func Load() -> Dictionary:
	if not FileAccess.file_exists(saveDataStorage):
		return {"":""}# Error! We don't have a save to load.
	var save_file = FileAccess.get_file_as_string(saveDataStorage)
	var json_as_dict = JSON.parse_string(save_file)
	return json_as_dict
