extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.animate()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ScrollingOceanFloor.move_x(100*delta)
