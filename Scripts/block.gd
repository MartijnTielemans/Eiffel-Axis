extends StaticBody2D

var speed = 45
var spawn_pos : Vector2
var spawner_ref : Node2D
var start_left : bool
var awarded_points = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = spawn_pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir = ((int(start_left)*-2)+1)
	position.x -= 45 * delta * dir
	print(dir)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player_Bullet:
		body.destroy_self()

func lose_points():
	awarded_points = 0

func die():
	spawner_ref.update_enemy_count(-1,awarded_points)
	queue_free()
