extends AnimatedSprite2D

@export var player : Player

func _process(_delta):
	if player.velocity == Vector2.ZERO:
		play("Idle")
		
	if player.velocity.y < 0 or player.stuck:
		play("Jumping")
	elif player.fall:
		play("Falling")
	elif player.velocity.x != 0 and (player.direction != 0):
		play("Running")
	
	if player.direction == -1:
		flip_h = true
	if player.direction == 1:
		flip_h = false
