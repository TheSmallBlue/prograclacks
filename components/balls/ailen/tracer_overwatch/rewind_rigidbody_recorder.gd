extends RewindRecorder

func _get_node_state() -> Variant:
	var parent = get_parent()
	
	if(parent == null):
		return null
	
	if(!parent is RigidBody2D):
		return null
	
	return (parent as RigidBody2D).global_position

func _set_node_state(state):
	var statePosition = state as Vector2
	var parent = get_parent() as RigidBody2D
	
	parent.global_position = statePosition
