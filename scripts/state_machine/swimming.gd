extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	player.animation_player.play("swim")

func physics_update(delta: float) -> void:
	var direction := Input.get_axis("player_up", "player_down")
	player.velocity.y = move_toward(player.velocity.y, direction * player.speed, player.acceleration*delta)
	
	if player.move_and_slide():
		player.velocity.y *= -0.2 # 0.001 ** delta
