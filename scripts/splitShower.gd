extends Label

@export var me : Label

func appear(time):
	var tween = get_tree().create_tween()
	
	tween.tween_property(me, "modulate", Color.BLACK, 1)
	
	text = time
	
