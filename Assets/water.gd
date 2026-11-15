extends Area2D

# Slows everything down while the player is inside, so the water section feels
# heavy and underwater. Engine.time_scale is global, so it must be put back to
# 1.0 on the way out - killzone.gd also restores it when the scene reloads.
@export var UNDERWATER_TIME_SCALE = 0.5


func _on_body_entered(_body):
	Engine.time_scale = UNDERWATER_TIME_SCALE


func _on_body_exited(_body):
	Engine.time_scale = 1.0
