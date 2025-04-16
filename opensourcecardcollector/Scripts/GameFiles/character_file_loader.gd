extends Node
class_name CardLoader
@export var displayer : Control

var character_files : Array[CharacterResource]

func Load(path : String = "C:/Users/Pc/Documents/OSGFiles/Characters") -> bool:
	character_files.clear()
	var characters : Array[CharacterResource]
	var dir = DirAccess.open(path)
	if !dir:
		return false
	var file = path
	CreateCharactersFromFiles(file)
	characters.append_array(CreateCharactersFromFiles(file))
	character_files.append_array(characters)
	showCharacters(character_files)
	#for i in character_files:
		#print(i.Name)
	return true

func showCharacters(chars : Array[CharacterResource]):
	for i in chars:
		displayer.CreateCard(i)

func CreateCharactersFromFiles(path : String) -> Array[CharacterResource]:
	var characters : Array[CharacterResource]
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
				var dir_path = path + "/" + file_name + "/"
				characters.append(CreateCharacterResource(dir_path))
			else:
				print("Found file: " + file_name)
			file_name = dir.get_next()
		pass
	else:
		print("An error occurred when trying to access the path.")
	return characters

func CreateCharacterResource(path : String) -> CharacterResource:
	var char = CharacterResource.new()
	#image
	var charImage
	if FileAccess.file_exists(path + "sprite.png"):
		charImage = Image.load_from_file(path + "sprite.png")
	elif FileAccess.file_exists(path + "sprite.jpg"):
		charImage = Image.load_from_file(path + "sprite.jpg")
	var charSprite : Texture2D = ImageTexture.create_from_image(charImage)
	#info
	var charName = ""
	var charSubtitle = ""
	var charCredits = ""
	var charDescription = ""
	var charTags : Array[String] = ["untagged"]
	var charOffset = Vector2.ZERO
	var json_as_text = FileAccess.get_file_as_string(path + "info.json")
	var json_as_dict = JSON.parse_string(json_as_text)
	if json_as_dict:
		if json_as_dict.has("name"):
			charName = json_as_dict["name"]
		if json_as_dict.has("subtitle"):
			charSubtitle = json_as_dict["subtitle"]
		if json_as_dict.has("credits"):
			charCredits = json_as_dict["credits"]
		if json_as_dict.has("description"):
			charDescription = json_as_dict["description"]
		if json_as_dict.has("tags"):
			charTags.clear()
			charTags.append_array(json_as_dict["tags"])
		if json_as_dict.has("horizontal offset"):
			charOffset.x = float(json_as_dict["horizontal offset"])
	#create
	char.Create(charSprite, charName, charSubtitle, charCredits, charDescription, charOffset)
	char.AddTags(charTags)
	return char
