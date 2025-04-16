extends Panel

@export_range(0,5) var fadeInSpeed : float = 1.0
@export_range(0,5) var fadeOutSpeed : float = 1.0
var fading = false
var timer = 0
var goal = 0
var color_transparent = Color.TRANSPARENT
var color_white = Color.WHITE

func _process(delta: float) -> void:
	if fading:
		if goal == 1:
			timer += delta * fadeInSpeed
			if timer >= 1:
				timer = 1
				fading = false
		elif goal == 0:
			timer -= delta * fadeOutSpeed
			if timer <= 0:
				timer = 0
				fading = false
		modulate = lerp(color_transparent, color_white, timer)

func FadeIn():
	goal = 1
	fading = true
	pass

func FadeOut():
	goal = 0
	fading = true
	pass
