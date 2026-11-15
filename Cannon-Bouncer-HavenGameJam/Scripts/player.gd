extends CharacterBody2D



const JUMP_VELOCITY = -500.0
var jumpDir : Vector2
var regularFriction = 900
var friction = regularFriction
@export var iceFriction = 90
@export var mag_size : int = 2
var bullets := mag_size
@onready var timer : Timer = $Timer
@onready var gun : Node2D = $Gun
@onready var deathScreen = preload("res://Scenes/death_screen.tscn")

func _ready() -> void:
	timer.timeout.connect(timer_end)
	Eventbus.KillPlayer.connect(die)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	jumpDir = (get_global_mouse_position()- self.position).normalized()
	gun.rotation = atan2(jumpDir.y,jumpDir.x)
	if is_on_floor():
		velocity.x = move_toward(velocity.x,0,friction * delta)
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and bullets:
		velocity = JUMP_VELOCITY * jumpDir
		bullets -= 1
	if bullets < mag_size && timer.is_stopped():
		timer.start()
	
	Eventbus.MagUpdate.emit(bullets,mag_size)
	
	move_and_slide()

func timer_end():
	if bullets < mag_size && is_on_floor():
		bullets +=1

func die():
	var spawn = deathScreen.instantiate()
	get_tree().current_scene.add_child(spawn)
	self.queue_free()

func Ice():
	friction = iceFriction
func ExitIce():
	friction = regularFriction
