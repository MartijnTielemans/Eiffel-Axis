extends StaticBody2D
class_name Block

var speed = 45
var spawn_pos : Vector2 = Vector2(-9999,-9999)
var spawner_ref : Node2D
@export var start_left : bool
var awarded_points = 0
@export var destroyParticles : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not spawn_pos == Vector2(-9999,-9999):
		global_position = spawn_pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir = ((int(start_left)*-2)+1)
	position.x -= 45 * delta * dir

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player_Bullet:
		MusicManager.play_player_bullet_sound_effect("BlockHit")
		body.destroy_self()

func lose_points():
	awarded_points = 0

func destroy_self():
	var DestroyParticle = load("res://Scenes/Visuals/BlockBreak.tscn")
	var particle : CPUParticles2D = destroyParticles.instantiate()
	particle.global_position = global_position
	get_tree().root.add_child(particle)
	particle.emitting = true
	queue_free()

func die():
	if not spawner_ref == null:
		spawner_ref.update_enemy_count(-1,awarded_points)
	queue_free()
