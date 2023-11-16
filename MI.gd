extends KinematicBody2D


const UP = Vector2(0, -1)
const GRAVITY = 15
const MAXFALLSPEED = 200
const MAXSPEED = 30
const JUMPFORCE = 300
const ACCELARATION = 13
const MAXHEALTH = 50

var motion = Vector2()
var facingRight = 1
var is_dead = false

var currentHealth = MAXHEALTH
#var sprite = $Sprite

func _ready():
	$EnemyHealthBar._on_max_health_updated(MAXHEALTH)
	pass

func hit(damage):
	currentHealth = currentHealth - damage
	if currentHealth <= 0:
		dead()
	
func dead():
	is_dead = true
	motion = Vector2.ZERO
	$AnimationPlayer.play("Dead")
	$CollisionShape2D.call_deferred("set_disabled", true)
	queue_free()
	
	
func _physics_process(delta):
	$EnemyHealthBar._on_health_updated(currentHealth)
	$EnemyHealthBar
	if is_dead==false:
		#motion.x = MAXSPEED * facingRight
		$AnimationPlayer.play("Dead")
		motion.y += GRAVITY
		if motion.y > MAXFALLSPEED:
			motion.y = MAXFALLSPEED
		motion = move_and_slide(motion, UP)

			
		if facingRight == 1:
			$Sprite.flip_h = false
		else:
			$Sprite.flip_h = true

