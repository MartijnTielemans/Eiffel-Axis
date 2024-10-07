extends Area2D
class_name enemy_bullet
var spawnPos : Vector2
var x_speed : int
var y_speed : int
@onready var UI_ref = $"../Control"
@export var bulletHitParticle : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = spawnPos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += (x_speed) * delta 
	position.y += (y_speed) * delta 

func destroy_self():
	var hitParticle : CPUParticles2D = bulletHitParticle.instantiate()
	hitParticle.position = position
	hitParticle.direction.x = -sign(x_speed)
	hitParticle.direction.y = sign(y_speed)
	get_tree().root.add_child(hitParticle)
	hitParticle.emitting = true
	print("particle")
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.update_health(-1)
		UI_ref.update_visuals()
	if not body is Player_Bullet:
		destroy_self()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
