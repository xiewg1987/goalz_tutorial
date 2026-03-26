class_name Dial extends Sprite2D

var rotating := false
var rotating_speed := 200

func _process(delta: float) -> void:
	if not rotating: return
	rotate(deg_to_rad(rotating_speed * delta))


func start_rotating() -> void:
	rotating = true


func stop_rotating() -> void:
	rotating = false
