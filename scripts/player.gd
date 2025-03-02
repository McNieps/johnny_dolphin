class_name Player extends CharacterBody2D

@export var speed := 500.0
@export var acceleration := 1600.0
@export var gravity := acceleration


const SPEED_TO_MAX_ANGLE := 600
const ANGLE_WHEN_MAX_SPEED := deg_to_rad(45)

@onready var animation_player := $animation_player


func _process(_delta: float) -> void:
	rotation = velocity.y/SPEED_TO_MAX_ANGLE*ANGLE_WHEN_MAX_SPEED

func _on_sea_on_water_enter(body: Node2D) -> void:
	if body.name == "Player":
		$StateMachine._transition_to_next_state("Swimming")

func _on_sea_on_water_leave(body: Node2D) -> void:
	if body.name == "Player":
		$StateMachine._transition_to_next_state("Jumping")
