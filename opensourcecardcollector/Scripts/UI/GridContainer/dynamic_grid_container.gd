extends GridContainer

@export var target_children_length : int = 100
@export var margin_of_error : int = 10

#dynamically change the column ammount of the grid to fit its size.

func _on_resized() -> void:
	changeColumns()
	pass # Replace with function body.

func changeColumns():
	print("size changed, width:" + str(size.x))
	columns = 1
	if size.x < target_children_length:
		return
	while (columns * target_children_length) < (size.x + margin_of_error):
		columns += 1
	while (columns * target_children_length) > (size.x - margin_of_error):
		columns -= 1
		if columns <= 0:
			columns = 1
	print("columns:" + str(columns))
	pass
