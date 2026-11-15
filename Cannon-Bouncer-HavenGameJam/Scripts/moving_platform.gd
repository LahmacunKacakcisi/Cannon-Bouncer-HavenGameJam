extends AnimatableBody2D

@export var speed := 100
var startpos := self.position
@onready var targetpos : Vector2 = $"Target Position".position
var isgoing := true
@onready var direction := targetpos - startpos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if isgoing:
		self.position += direction.normalized() * speed * delta
	else:
		self.position += -direction.normalized() * speed * delta
	
	clampf(self.position.x,startpos.x,targetpos.x)
	clampf(self.position.y,startpos.y,targetpos.y)
	
	if self.position == targetpos :
		isgoing = false
	elif self.position == startpos:
		isgoing = true
	
	
