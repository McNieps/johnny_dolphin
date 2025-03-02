extends Node2D

signal on_water_enter(body: Node2D)  
signal on_water_leave(body: Node2D)

@export var splashable: bool = true
@export var splash_scene: PackedScene

func scroll_x(x_px: float) -> void:
	$ScrollingOceanFloor.scroll_x(x_px)


func _on_area_2d_body_entered(body: Node2D) -> void:
	on_water_enter.emit(body)
	if splashable:
		var splash = splash_scene.instantiate()
		splash.position.x = body.position.x
		splash.setup_water_enter(abs(body.velocity.y) / 500)
		add_child(splash)

func _on_area_2d_body_exited(body: Node2D) -> void:
	on_water_leave.emit(body)
	if splashable:
		var splash = splash_scene.instantiate()
		splash.position.x = body.position.x
		splash.setup_water_leave(abs(body.velocity.y) / 500)
		add_child(splash)
