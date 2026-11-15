extends Area2D

@onready var timer = $Timer

# Shared by every killzone so two overlapping ones can't reload the scene twice.
# Static vars survive reload_current_scene(), so it is reset in _ready().
static var dying = false


func _ready():
	dying = false
	# Engine.time_scale is global and survives reload_current_scene().
	Engine.time_scale = 1.0


func _on_body_entered(_body):
	if dying:
		return
	dying = true
	print("you died")
	Engine.time_scale = 0.5
	timer.start()


func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
