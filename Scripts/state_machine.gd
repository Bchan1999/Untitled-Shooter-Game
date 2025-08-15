extends Node
class_name StateMachine

var current_state : State
var states : Dictionary = {}
var _parent_node_name : String

func start_machine(init_states: Array[State]) -> void:
	_parent_node_name = get_parent().name
	
	for state in init_states:
		states[state.get_state_name()] = state
		
	current_state = init_states[0]
	current_state.enter()
	

#func _ready():
	#for child in get_children():
		#if child is State:
			#states[child.name.to_lower()] = child
			#child.Transitioned.connect(on_child_transition)
			#
	#if initial_state:
		#print(initial_state)
		#initial_state.enter()
		#current_state = initial_state

func _process(delta):
	if current_state:
		current_state.update(delta)
		
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func transition(new_state_name: String):
	var new_state: State = states.get(new_state_name)
	var current_state_name = current_state.get_state_name()
	
	#in case someone transistions to state that doesnt exist
	if new_state == null:
		push_error("An attempt has been made to transition to a non-existent state (%s)." % new_state_name)
	elif new_state != current_state:
		current_state.exit()
		current_state = new_state
		
		current_state.enter()
	else:
		push_warning("An attempt to transistion to current state has been made. Ignoring request")
		
		
	
