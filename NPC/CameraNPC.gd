extends "res://Characters/Character.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const FOV_TOLERANCE = deg2rad(20)
const RED = Color(1.0, 0.0, 0.0)
const WHITE = Color(1,1,1)
const MAX_DETECTION_RANGE = 640

var Player

# Called when the node enters the scene tree for the first time.
func _ready():
	Player = get_node("/root").find_node("Player", true, false)
	print(Player)
	$CameraBody/AnimationPlayer.play("rotate")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Player_in_FOV() and Player_in_LOS():
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

func Player_in_LOS():
	var space = get_world_2d().direct_space_state
	var LOS_obstacle = space.intersect_ray($CameraBody.global_position, Player.global_position, [self], collision_mask)
	if not LOS_obstacle:
		return false
	var distance_to_player = Player.global_position.distance_to(global_position)
	#print(LOS_obstacle.collider)
	if LOS_obstacle.collider == Player:
		print("Player detected")
		return true
	else:
		return false
