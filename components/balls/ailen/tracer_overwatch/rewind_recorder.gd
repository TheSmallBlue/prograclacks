@abstract
extends Node
class_name RewindRecorder 

var states : Array[Variant]

func record_node(frame : int) -> void:
	states.append(_get_node_state())

func restore_node(frame : int) -> void:
	_set_node_state(states[frame])

func clear_states() -> void:
	states.clear()
	
@abstract 
func _get_node_state() -> Variant

@abstract
func _set_node_state(state)
