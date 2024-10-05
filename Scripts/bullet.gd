extends CharacterBody2D
class_name Player_Bullet

const SPEED = 200			#How much the bullet moves per second
var spawnPos : Vector2		#This value is set by the player_character when spawned
var player_ref : CharacterBody2D
var health = 3
var dir : int

@export var bulletHitParticle : PackedScene

# Sets the position of the bullet to the position given by the player_character
func _ready() -> void:
	global_position = Vector2(spawnPos)
	$Sprite2D.flip_h = bool((dir-1)/2)
# Moves the bullet to the right
func _physics_process(delta: float) -> void:
	position.x += SPEED * delta * dir

func destroy_self():
	var hitParticle : CPUParticles2D = bulletHitParticle.instantiate()
	hitParticle.position = position
	hitParticle.direction.x = -dir
	get_tree().root.add_child(hitParticle)
	hitParticle.emitting = true
	player_ref.update_projectile_amount(-1)
	
	queue_free()
	print("destroy self")

func flip_bullet():
	$Sprite2D.flip_v = !$Sprite2D.flip_v
