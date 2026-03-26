class_name Goal extends Sprite2D

var goal_entered = false
@onready var goal_audio: AudioStreamPlayer = %GoalAudio


func _on_goal_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Ball"):
		goal_entered = true
		goal_audio.play()
