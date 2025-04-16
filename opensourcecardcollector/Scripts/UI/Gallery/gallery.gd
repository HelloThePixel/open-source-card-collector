extends Control

@export_category("DEBUG - Cards")
@export var debugCards : Array[CharacterResource]
@export_category("DEBUG - Create Card")
@export var DebugCard : bool = false
@export var Name : String
@export var Subtitle : String
@export var Sprite : Texture2D
@export var SpriteOffset : Vector2 = Vector2.ZERO

@export_category("Nodes To Create")
@export var cardTemplate : PackedScene

@export_category("Scene Elements")
@export var cardLoader : CardLoader
@export var cardContainer : GridContainer
@export var cardFocusHide : Panel
@export var screenCenter : Control
@export var cardPathInput : TextEdit
@export var settingsPanel : Panel
@export var blockedTags : TextEdit

#connects
var cardList : Array[CharacterUIElement]
var focusedCard : CharacterUIElement

func _ready() -> void:
	cardPathInput.text = SaveManager.LoadSaveCardDirectoryPath()
	if !debugCards.is_empty():
		for i in debugCards:
			CreateCard(i)
	if DebugCard:
		var e : CharacterResource = CharacterResource.new()
		e.Create(Sprite, Name, Subtitle, SpriteOffset)
		CreateCard(e)

func CreateCard(char : CharacterResource):
	var card : CharacterUIElement = cardTemplate.instantiate()
	AddCard(card)
	card.Set(char)

func AddCard(card : Panel):
	card.position = Vector2.ZERO
	cardContainer.add_child(card)
	cardList.append(card)
	card.handler = self
	pass

func ChangeFocus(card : CharacterUIElement):
	if focusedCard != null:
		if card == focusedCard:
			focusedCard.Focus(false)
			focusedCard.Enabled(false)
			focusedCard = null
			for i in cardList:
				i.Enabled(true)
			cardFocusHide.FadeOut()
			return
		focusedCard.Focus(false)
	for i in cardList:
		i.Enabled(false)
	focusedCard = card
	focusedCard.Focus(true, screenCenter.global_position)
	focusedCard.Enabled(true)
	cardFocusHide.FadeIn()
	pass

func ClearCards():
	print("CLEAR")
	for i in cardContainer.get_children():
		i.queue_free()
	cardList.clear()
	return
	#i hope i dont need da rest
	var dad = cardContainer.get_parent()
	dad.add_child(cardContainer.duplicate())
	print("dad: " + str(dad.name))
	for i in dad.get_children():
		print("son: " + str(i.name))
	cardContainer.queue_free()
	cardContainer = dad.get_child(1)
	print("new son: " + str(cardContainer.name))
	pass

func LoadCards():
	if cardPathInput.text != "":
		ClearCards()
		cardLoader.Load(cardPathInput.text)
		SaveManager.SaveCardDirectoryPath(cardPathInput.text)
	TagBlocker(blockedTags.GetTags())
	pass


func _on_settings_pressed() -> void:
	settingsPanel.visible = true
	pass # Replace with function body.


func _on_settings_exit_pressed() -> void:
	settingsPanel.visible = false
	pass # Replace with function body.

func TagBlocker(block : PackedStringArray):
	for i in cardList:
		i.Blocked(false)
	for e in CommonMethods.FilterByTags(cardList, block, true, true, true):
		e.Blocked(true)
	
	return #delete next code later
	print("blocked tags: "+str(block))
	for i in cardList:
		var hasIt = false
		for e in block:
			if !hasIt:
				print(e)
				e = e.strip_edges(true, true)
				if e != "" and e!= " " and e!= ",":
					print("tag " + e + " is not null")
					if i.tags.has(e):
						hasIt = true
					else:
						if i.characterName.contains(e.to_lower()):
							hasIt = true
							print("its the name")
						elif i.characterCredits.contains(e.to_lower()):
							hasIt = true
							print("its the author")
						else:
							hasIt = false
				else:
					print("tag " + e + " IS nothing")
		i.visible = !hasIt

func Filter(search : PackedStringArray):
	
	for i in cardList:
		i.visible = false
	for i in CommonMethods.FilterByTags(cardList, search, false, true):
		i.visible= true
		
	TagBlocker(blockedTags.GetTags())
