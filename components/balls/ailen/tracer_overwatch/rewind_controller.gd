extends Node
class_name RewindController

@export var rewind_recorders : Array[RewindRecorder]
@export var playback_speed_multiplier : float = 1

signal playback_done

enum {STATE_NONE, STATE_RECORDING, STATE_PLAYBACK}

var state = STATE_NONE
var current_frame : int
var playback_delta : float
var playback_frames : int

func _process(delta: float) -> void:
	#print(state)
	match state:
		STATE_NONE:
			pass
		STATE_RECORDING:
			_recording_process()
		STATE_PLAYBACK:
			_playback_process(delta)

func _recording_process() -> void:
	for recorder in rewind_recorders:
		recorder.record_node(current_frame)
	
	current_frame += 1

func _playback_process(delta : float) -> void:
	for recorder in rewind_recorders:
		recorder.restore_node(current_frame)
	current_frame -= 1 * playback_speed_multiplier
	playback_frames -= 1 * playback_speed_multiplier
	
	if(playback_frames <= 0):
		state = STATE_NONE
		playback_done.emit()

func start_recording() -> void:
	for recorder in rewind_recorders:
		recorder.clear_states()
	
	current_frame = 0
	state = STATE_RECORDING

func start_playback(frames : int) -> void:
	current_frame -= 1
	playback_frames = frames
	state = STATE_PLAYBACK
