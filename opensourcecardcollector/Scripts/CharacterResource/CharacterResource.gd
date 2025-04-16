extends Resource
class_name CharacterResource

@export var Name : String
@export var Subtitle : String
@export var Credits : String
@export var Description : String
@export var Sprite : Texture2D
@export var SpriteOffset : Vector2 = Vector2.ZERO
@export var Tags : Array[String]
#@export var SpriteZoom : float = 1.0

func Create(img : Texture2D, n = "???", m = "...", c = "", d = "", offset = Vector2.ZERO):
	if n == "":
		n = "???"
	if m == "":
		m = "..."
	if c == "":
		c = "(Uncredited)"
	Sprite = img
	Name = n
	Subtitle = m
	Credits = c
	Description = d
	SpriteOffset = offset

func AddTags(e : Array[String]):
	Tags.append_array(e)
