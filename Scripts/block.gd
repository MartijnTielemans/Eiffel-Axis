extends StaticBody2D

var speed = 45
var spawn_pos : Vector2
var spawner_ref : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = spawn_pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= 45 * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player_Bullet:
		body.destroy_self()
