extends CharacterBody2D


const SPEED := 500.0
const ACCELERATION := 1600

const SPEED_TO_MAX_ANGLE := 600
const ANGLE_WHEN_MAX_SPEED := deg_to_rad(45)


func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("player_up", "player_down")
	velocity.y = move_toward(velocity.y, direction * SPEED, ACCELERATION*delta)
		

	move_and_slide()


func _process(delta: float) -> void:
	rotation = velocity.y/SPEED_TO_MAX_ANGLE*ANGLE_WHEN_MAX_SPEED


func animate() -> void:
	$AnimatedSprite2D.play("swim")
