@tool
extends Label3D

func _process(_delta):
	if Engine.is_editor_hint():
		update_text()
#
func update_text():
	if get_parent():
		if get_parent().name != 'Exit_template':
			text = get_parent().name
		else: 
			text = ''
