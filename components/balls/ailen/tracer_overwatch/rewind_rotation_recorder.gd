extends RewindRecorder

func _get_node_state() -> Variant:
	var parent = get_parent()
	
	if(parent == null):
		return null
	
	if(!parent is Node2D):
		return null
	
	return (parent as Node2D).global_rotation

func _set_node_state(state):
	var stateRotation = state as float
	var parent = get_parent() as Node2D
	
	parent.global_rotation = stateRotation
