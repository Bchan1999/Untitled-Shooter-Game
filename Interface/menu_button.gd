extends MenuButton

var pop : PopupMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pop = get_popup()
	pop.hide_on_checkable_item_selection = false
	pop.id_pressed.connect(menu_pressed)

func menu_pressed(id) -> void:
	pop.toggle_item_checked(id)
	if pop.is_item_checked(id):
		GameDebug.set_show_exit_property(true)
	else:
		GameDebug.set_show_exit_property(false)
	
