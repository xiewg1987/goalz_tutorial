class_name Level1 extends Node2D

@onready var goal: Goal = %Goal
@onready var change_scene_timer: Timer = %ChangeSceneTimer
@onready var scene_transition: SceneTransition = %SceneTransition

var timer_called = false


func _process(_delta: float) -> void:
	if not goal.goal_entered: return
	if timer_called: return
	scene_transition.animation.play("SwipeDown")
	change_scene_timer.start()
	timer_called = true


func _on_change_scene_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level2/level_2.tscn")
