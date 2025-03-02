extends CPUParticles2D

var speed_mult: float
var sound_to_play: AudioStreamPlayer2D

const PARTICLE_SPAWN_THRESHOLD := 0.1
const MAX_PITCH_VAR := 0.2
const MIN_SOUND_DB := 15.0


func setup_water_enter(passed_speed_mult: float) -> void:
	self.speed_mult = clamp(passed_speed_mult, 0, 1)
	self.sound_to_play = $SoundWaterEnter
	
	# particle part
	explosiveness = 0.9

func setup_water_leave(passed_speed_mult: float) -> void:
	self.speed_mult = clamp(passed_speed_mult, 0, 1)
	sound_to_play = $SoundWaterLeave
	
	# particle part
	explosiveness = 0.95


func _ready():
	sound_to_play.volume_db = -MIN_SOUND_DB+MIN_SOUND_DB*speed_mult
	
	if speed_mult >= PARTICLE_SPAWN_THRESHOLD:
		initial_velocity_min *= speed_mult
		initial_velocity_max *= speed_mult
		lifetime *= speed_mult
		emitting = true
	
	sound_to_play.pitch_scale += randf() * MAX_PITCH_VAR - MAX_PITCH_VAR / 2
	sound_to_play.play()
	await get_tree().create_timer(lifetime).timeout
	queue_free()
