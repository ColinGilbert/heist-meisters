extends "res://Characters/Character.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const FOV_TOLERANCE = deg2rad(10)
const RED = Color(1.0, 0.0, 0.0)
const WHITE = Color(1,1,1)

var Player

# Called when the node enters the scene tree for the first time.
func _ready():
	Player = get_node("/root").find_node("Player", true, false)
	$CameraBody/AnimationPlayer.play("rotate")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Player_in_FOV():
		$CameraBody/CameraLight.color = RED
	else:
		$CameraBody/CameraLight.color = WHITE		
		
func Player_in_FOV():
	var npc_facing_direction = Vector2(1,0).rotated($CameraBody.global_rotation)
	var direction_to_Player = (Player.position - $CameraBody.global_position).normalized()
	if abs(direction_to_Player.angle_to(npc_facing_direction)) < FOV_TOLERANCE:
		return true
	else:
		return false
