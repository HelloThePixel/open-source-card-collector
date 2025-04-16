extends Control

#DEBUG STUFF
#@export_category("DEBUG - Cards")
#@export var debugCards : Array[CharacterResource]
#@export_category("DEBUG - Create Card")
#@export var DebugCard : bool = false
#@export var Name : String
#@export var Subtitle : String
#@export var Sprite : Texture2D
#@export var SpriteOffset : Vector2 = Vector2.ZERO

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
	#DEBUG STUFF
	#if !debugCards.is_empty():
	#	for i in debugCards:
	#		CreateCard(i)
	#if DebugCard:
	#	var e : CharacterResource = CharacterResource.new()
	#	e.Create(Sprite, Name, Subtitle, SpriteOffset)
	#	CreateCard(e)

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
	for i in cardContainer.get_children():
		i.queue_free()
	cardList.clear()
	return

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
	#search through cardlist using the tag list "block". inclusive: true. include name? true. exact? true
	for e in CommonMethods.FilterByTags(cardList, block, true, true, true):
		e.Blocked(true)

func Filter(search : PackedStringArray):
	
	for i in cardList:
		i.visible = false
	#search through cardlist using the tag list "search". inclusive: false. include name? true. exact? true
	for i in CommonMethods.FilterByTags(cardList, search, false, true, true):
		i.visible= true
		
	TagBlocker(blockedTags.GetTags())
