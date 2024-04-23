extends CharacterBody2D
class_name Player

@export var speed : float = 300
@export var jumpPower : float = -450
@export var defaultGravity : float = 500
var gravity : float = defaultGravity

@export var acceleration : float = 15
@export var defaultFriction : float = 10
var friction : float = defaultFriction

@export var stickTime : float = 3
@export var stickTimer : Timer
var stuck : bool = false

var fall : bool = true
var canJump : bool = true
var direction : int	

var spawnPoint : Node2D

@onready var globalTimer : Node = get_node("/root/GlobalTimer")

var cayoteTimeToggle : bool = false
@export var cayoteMaxTime : float
var cayoteTimeLeft : float = 0.0
var hasJumped : bool = false
var canCayote : bool = false

@export var bounceVel : float = jumpPower * 1.3

func _ready():
	spawnPoint = get_tree().get_first_node_in_group("SpawnPoint")
	global_position = spawnPoint.global_position
	globalTimer.startTimer()
	
func _physics_process(delta):
	
	if gravity >= 1300:
		gravity = 1330
	
	if is_on_ceiling() and (Input.is_action_pressed("jump")):
		stickTimer.start(stickTime)
		stuck = true

	if is_on_floor():
		canCayote = false
		hasJumped = false
		cayoteTimeLeft = cayoteMaxTime

	if not is_on_floor():
		cayoteTimeToggle = true

	if cayoteTimeToggle:
		canCayote = true
		cayoteTimeLeft -= delta
	
	if cayoteTimeLeft <= 0:
		canCayote = false

	if hasJumped:
		canCayote = false

	if not is_on_ceiling():
		stuck = false

	if ((is_on_ceiling() and Input.is_action_pressed("jump")) or stuck) or is_on_floor():
		fall = false
		canJump = true
		gravity = defaultGravity
	else:
		stuck = false
		fall = true

	if fall:
		canJump = false
		gravity += 20
		velocity.y += gravity * delta

	if Input.is_action_pressed("jump") and (is_on_floor() or is_on_ceiling() or (canJump or canCayote)):
		hasJumped = true
		canCayote = false
		
		velocity.y = jumpPower - (abs(velocity.x) / 10)
		

	print(canCayote)
	if velocity.y < 0 and Input.is_action_just_released("jump"):
		velocity.y /= 1.5
		
	direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, friction)

	move_and_slide()
	


func _on_stick_timer_timeout():
	stuck = false

func kill():
	global_position = spawnPoint.global_position

func bounce():
	if velocity.y > 10:
		velocity.y = ((velocity.y / 1.19) * -1) + (bounceVel / 2) - (abs(velocity.x / 2))
		return
	else:
		velocity.y = bounceVel - (abs(velocity.x / 2))
