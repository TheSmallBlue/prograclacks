extends Ball

@export var movement_speed : float = 100
@export_group("Rewind values")
@export var rewind_controller : RewindController
@export var rewind_time_seconds : float = 5
@export var rewind_timer : Timer
@export_group("Gun values")
@export var bullet_sources : Array[Node2D]
@export var bullet_scene : PackedScene
@export_group("Visuals")
@export var effect_rewind : Sprite2D
@export var guns_node : Node2D

var movement_direction : Vector2 = Vector2.UP
var current_bullet_source : int = 0

func _ready() -> void:
	rewind_controller.start_recording()

func ball_physics_process(delta : float):
	if(rewind_controller.state == rewind_controller.STATE_PLAYBACK):
		return
	
	movement_direction = movement_direction.rotated(randf_range(-1, 1))
	apply_force(movement_direction * movement_speed)
	
	guns_node.global_rotation = (linear_velocity).angle()
	

func _on_rewind_ready() -> void:
	freeze = true
	rewind_controller.start_playback(rewind_time_seconds * Engine.get_frames_per_second())
	effect_rewind.visible = true

func _on_rewind_controller_playback_done() -> void:
	var previous_position = global_position
	freeze = false
	global_position = previous_position
	
	movement_direction = Vector2.UP.rotated(randf_range(0, 360))
	
	rewind_controller.start_recording()
	rewind_timer.start()
	
	effect_rewind.visible = false


func _fire_bullet() -> void:
	if(rewind_controller.state == rewind_controller.STATE_PLAYBACK):
		return
	
	current_bullet_source = (current_bullet_source + 1) % bullet_sources.size()
	var bullet_spawn_pos = bullet_sources[current_bullet_source].global_position
	
	var bullet : Bullet = bullet_scene.instantiate() as Bullet
	get_parent().add_child(bullet)
	bullet.init(bullet_spawn_pos, linear_velocity.normalized(), self)
