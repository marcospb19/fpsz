extends Node3D

@export var player: Node3D

var health := 1000
var time := 0.0
var destroyed := false

@onready var raycast := $RayCast
@onready var muzzle_a := $MuzzleA
@onready var muzzle_b := $MuzzleB


func _process(delta):
	self.look_at(player.position + Vector3.UP * 0.5, Vector3.UP, true)  # Look at player
	position.y += cos(time * 5) * delta  # Sine movement (up and down)
	time += delta


# Take damage from player
func damage(amount):
	Audio.play_at("enemy_hurt.ogg")
	health -= amount
	
	if health <= 0 and !destroyed:
		Audio.play_at("enemy_destroy.ogg")
		destroyed = true
		self.queue_free()


# Shoot when timer hits 0
func _on_timer_timeout():
	raycast.force_raycast_update()
	
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		
		if collider.has_method("damage"):  # Raycast collides with player
			# Play muzzle flash animation(s)
			muzzle_a.play()
			muzzle_a.rotation_degrees.z = randf_range(0, 90)
			muzzle_b.play()
			muzzle_b.rotation_degrees.z = randf_range(0, 90)
			
			Audio.play_at("enemy_attack.ogg")
			collider.damage(5)  # Apply damage to player