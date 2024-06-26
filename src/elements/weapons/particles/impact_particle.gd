extends AnimatedSprite3D


func _on_animation_finished():
	self.queue_free()


func _process(_delta):
	update_scale_with_distance()


func update_scale_with_distance():
	const SPRITE_STARTING_SCALE := Vector3.ONE * 0.5
	const SCALING_INCREASE_RATE := 0.20
	const SCALING_INCREASE_DISTANCE_RANGE := Vector2(1.5, 15.0)
	
	var camera := Utils.main_camera
	if camera != null:
		var distance = self.global_position.distance_to(camera.global_position)
		var scale_increase = Utils.custom_growth_curve(
			distance, SCALING_INCREASE_RATE, SCALING_INCREASE_DISTANCE_RANGE
		)
		self.scale = SPRITE_STARTING_SCALE * (1 + scale_increase)
