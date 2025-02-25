extends Node2D
@export var image_dir: String
var sprite_pool: Array = []  # Pool of all available sprites
var active_sprites: Array = []  # Sprites currently in use
var sprite_width: float = 128
var num_visible_sprites: int = 0
var accumulated_movement: float = 0.0

func _ready():
	load_sprites()
	position_sprites()

func load_sprites():
	var dir = DirAccess.open(image_dir)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".png"):  # Adjust for your image format
				var texture = load(image_dir + "/" + file_name)
				var sprite = Sprite2D.new()
				sprite.texture = texture
				sprite_pool.append(sprite)
				add_child(sprite)
				sprite.hide()
			file_name = dir.get_next()
	else:
		print("Error: Could not open directory ", image_dir)

func position_sprites():
	var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")
	num_visible_sprites = ceil(screen_width / sprite_width) + 2  # Add one for buffer
	for i in range(num_visible_sprites):
		var sprite = sprite_pool.pop_front()  # Take a sprite from the pool
		sprite.position.x = i * sprite_width
		active_sprites.append(sprite)
		sprite.show()

func move_x(px: float):
	self.accumulated_movement += px
	
	@warning_ignore("narrowing_conversion")
	var displacement: int = int(floor(self.accumulated_movement))
	self.accumulated_movement -= displacement
	
	if not displacement:
		return
		
	for sprite in active_sprites:
			
		sprite.position.x -= displacement
		# If a sprite moves off-screen, recycle it
		if sprite.position.x < -sprite_width:
			recycle_sprite(sprite)

func recycle_sprite(sprite: Sprite2D):
	sprite.hide()
	active_sprites.erase(sprite)
	sprite_pool.append(sprite)
	# Randomly select a new sprite from the pool
	var new_sprite = sprite_pool.pop_at(randi() % sprite_pool.size())
	new_sprite.show()
	new_sprite.position.x = active_sprites[-1].position.x + sprite_width
	active_sprites.append(new_sprite)
	
