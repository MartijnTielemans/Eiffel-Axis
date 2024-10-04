extends Node2D

@export var x_speed : int = 60
@export var y_speed : int = 0
@export var image = load("res://Assets/Enemies/Enemy_CapsuleOpen_Bottom.png")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.texture = image

func change_opacity():
	$Sprite2D.visible = !$Sprite2D.visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += x_speed * delta
	y_speed += 2
	position.y += y_speed * delta
	
