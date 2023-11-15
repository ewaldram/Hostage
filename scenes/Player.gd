extends Node2D

signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	#hide()  will hide the player if needed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		$AnimatedSprite2D.animation = "walk_right"
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		$AnimatedSprite2D.animation = "walk_left"
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		$AnimatedSprite2D.animation = "walk_down"
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		$AnimatedSprite2D.animation = "walk_up"

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	else:
		$AnimatedSprite2D.animation = "idle"
		
	$AnimatedSprite2D.play()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
#unused func, get hit
#func _on_body_entered(body):
#	hide() # Player disappears after being hit.
#	hit.emit()
#	# Must be deferred as we can't change physics properties on a physics callback.
#	$CollisionShape2D.set_deferred("disabled", true)
#
## Unused func, get starting pos
#func start(pos):
#	position = pos
#	show()
#	$CollisionShape2D.disabled = false
