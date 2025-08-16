#@tool
extends Label3D

func _process(_delta):
	if GameDebug.get_show_exit_property():
		update_text()
	else:
		no_text()
#
func update_text():
	if get_parent():
		text = get_parent().name
		
func no_text():
		text = ""
