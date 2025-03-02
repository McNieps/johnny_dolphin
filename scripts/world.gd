extends Node2D


func _process(delta: float) -> void:
	$Sea.scroll_x(500.0*delta)
