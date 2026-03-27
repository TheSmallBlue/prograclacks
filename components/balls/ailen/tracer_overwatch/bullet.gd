extends Area2D
class_name Bullet

@export var speed : float = 5
@export var damage : float = 5

var direction : Vector2
var shooter : Node2D

func init(position : Vector2, direction : Vector2, source : Node2D) -> void:
	global_position = position
	self.direction = direction
	shooter = source

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	for body in get_overlapping_bodies():
		if body is Ball:
			shooter.attack(body,damage)
		queue_free()
