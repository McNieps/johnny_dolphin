extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	player.animation_player.play("idle")

func physics_update(delta: float) -> void:
	player.velocity.y += player.acceleration*delta*0.75
	player.move_and_slide()

	# finished.emit(PlayerState.JUMPING)
