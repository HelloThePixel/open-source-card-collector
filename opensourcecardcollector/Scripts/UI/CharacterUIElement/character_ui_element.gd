extends Panel
class_name CharacterUIElement

@onready var image : TextureRect = $ImagePanel/TextureRect
@onready var imagePanel : Panel = $ImagePanel
@onready var imageButton : Button = $ImagePanel/ImageButton
@onready var title : RichTextLabel = $VBoxContainer/TextPanel/Title
var characterName : String = ""
@onready var subtitle : RichTextLabel = $VBoxContainer/TextPanel/Subtitle
@onready var creditsPanel : Panel = $VBoxContainer/CreditsPanel
@onready var credits : RichTextLabel = $VBoxContainer/CreditsPanel/CreditsLabel
var characterCredits : String = ""
@onready var descriptionPanel : Panel = $VBoxContainer/DescriptionPanel
@onready var description : RichTextLabel = $VBoxContainer/DescriptionPanel/DescriptionLabel
@onready var tagsPanel : Panel = $TagsPanel
@onready var tagsText : RichTextLabel = $TagsPanel/Tags
var tags = ["untagged"]
@export var defaultCharacter : CharacterResource

var defaultSize = Vector2(200,300)
var focusSize = Vector2(500,500)
var usualOffset = Vector2.ZERO
var defaultPosition = Vector2.ZERO
var focused = false
var focusTimer = 0.0
var goalPos = Vector2.ZERO
@export var growCurve : Curve

var handler : Node

#blocked
var blocked = false
@onready var blockPanel = $BlockPanel

func _ready() -> void:
	if defaultCharacter:
		Set(defaultCharacter)
	#print(position)
	descriptionPanel.visible = false
	defaultPosition = position
	tagsPanel.visible = false

func _process(delta: float) -> void:
	blockPanel.visible = blocked
	if focused:
		if focusTimer < 1:
			focusTimer += delta * 1.5
			if focusTimer > 1:
				focusTimer = 1
			set_size(lerp(defaultSize, focusSize, growCurve.sample_baked(focusTimer)))
			global_position = lerp(defaultPosition, goalPos, growCurve.sample_baked(focusTimer))

func Set(char : CharacterResource):
	SetImage(char.Sprite, char.SpriteOffset)
	SetTitle(char.Name)
	SetSubtitle(char.Subtitle)
	SetCredits(char.Credits)
	SetDescription(char.Description)
	SetTags(char.Tags)
	pass

func SetHandler(ow : Node):
	handler = ow

func SetImage(i : Texture2D, off : Vector2 = Vector2.ZERO, zoom : float = 1.0):
	if !i: return
	image.texture = i
	
	#var img_size = i.get_size()
	#var img_ratio := Vector2(1, 1)
	#img_ratio.x = img_size.x / img_size.y
	
	usualOffset = off
	image.position = usualOffset

func SetTitle(t : String):
	characterName = t.to_lower()
	var s : String = "[center][b]"
	s += t
	s += "[/b][/center]"
	title.text = s
	pass

func SetSubtitle(t : String):
	var s : String = "[center][i]"
	s += t
	s += "[/i][/center]"
	subtitle.text = s
	pass

func SetCredits(c : String):
	characterCredits = c.to_lower()
	var s : String = "[center][i]"
	s += c
	s += "[/i][/center]"
	credits.text = s

func SetDescription(c : String):
	var s : String = "[center][i]"
	s += c
	s += "[/i][/center]"
	description.text = s

func SetTags(e : Array[String]):
	tags.clear()
	#tags.append_array(e)
	for i in e:
		tags.append(i.to_lower())
		if tagsText.text != "":
			tagsText.text += ",\n"
		tagsText.text += "#" + i

func Focus(b : bool, e = Vector2.ZERO):
	if b:
		#print("focus!")
		image.position = Vector2.ZERO
		#set_size(focusSize)
		z_index = 1
		descriptionPanel.visible = true
		top_level = true
		defaultPosition = position
		goalPos = e
		focusTimer = 0.0
		focused = true
		tagsPanel.visible = true
		#imagePanel.clip_children = CanvasItem.CLIP_CHILDREN_DISABLED
	else:
		#print("un-focus!")
		image.position = usualOffset
		#for some reason this ^ changes the sizing if After set size.
		set_size(defaultSize)
		z_index = 0
		descriptionPanel.visible = false
		top_level = false
		position = defaultPosition
		focused= false
		tagsPanel.visible = false
		#imagePanel.clip_children = CanvasItem.CLIP_CHILDREN_AND_DRAW
	pass

func Blocked(b : bool):
	blocked = b

func Enabled(b : bool):
	if b:
		pass#imageButton.mouse_filter = Control.MOUSE_FILTER_STOP
	else:
		pass#imageButton.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_image_button_pressed() -> void:
	handler.ChangeFocus(self)
	pass # Replace with function body.
