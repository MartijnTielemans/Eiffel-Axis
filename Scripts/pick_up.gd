extends Area2D

@onready var player_character: CharacterBody2D = $"../PlayerCharacter"
@onready var UI_ref: Control = $"../Control"
@onready var spawner_ref: Node2D = $"../Wave_spawner"

var speed : int = 0
var HP : int = 0
var Points : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if player_character.HP < 3:
		$Sprite2D.texture = preload("res://Assets/Enemies/Pickup_Heart.png")
		HP = 1
	else:
		$Sprite2D.texture = preload("res://Assets/Enemies/Pickup_Star.png")
		Points = 1000


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * delta


func _on_body_entered(body: Node2D) -> void:
	body.HP += HP
	UI_ref.points += Points
	UI_ref.health += HP
	UI_ref.update_visuals()
	UI_ref.update_points()
	spawner_ref.points += Points
	queue_free()
	print(UI_ref.points)
