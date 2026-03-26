class_name Ball extends CharacterBody2D

const SPEED := 700 ## 速度
const GRAVITY := 400 ## 重力
const FRICTION := 0.91 ## 摩擦力
const JUMP_FPRCE := 500 ## 跳跃力
const POST_SHOT_VELOCITY := 50 ## 移动后速度

@onready var exclamation: Sprite2D = %Exclamation
@onready var dial: Dial = %Dial
@onready var ray_cast: RayCast2D = %RayCast2D
@onready var shoot_timer: Timer = %ShootTimer
@onready var tick_timer: Timer = %TickTimer
@onready var hit_wall_audio: AudioStreamPlayer = %HitWallAudio
@onready var shoot_audio: AudioStreamPlayer = %ShootAudio
@onready var tick_audio: AudioStreamPlayer = %TickAudio

var can_shoot := true ## 能否移动
var timer_called := false


func _physics_process(delta: float) -> void:
	var velocity := 0.0
	velocity = move_toward(velocity, 0, SPEED)
	apply_gravity(delta)
	apply_friction()
	update_shoot_ability()
	update_exclamation_visibility()
	shoot()
	move_and_slide()
	if timer_called: return
	if not dial.rotating: return
	tick_timer.start()
	timer_called = true


func shoot() -> void:
	if can_shoot:
		if Input.is_action_pressed("Touch"):
			start_shooting()
		elif Input.is_action_just_released("Touch"):
			shoot_audio.play()
			stop_shooting()


func apply_gravity(delta: float) -> void:
	if is_on_floor(): return
	velocity.y += GRAVITY * delta
	velocity.y = clamp(velocity.y, -JUMP_FPRCE, JUMP_FPRCE) 


func apply_friction() -> void:
	velocity *=  FRICTION


func update_shoot_ability() -> void:
	if velocity.length_squared() < POST_SHOT_VELOCITY:
		can_shoot = true
	else :
		can_shoot = false


func update_exclamation_visibility() -> void:
	exclamation.visible = can_shoot


func start_shooting() -> void:
	dial.start_rotating()
	dial.visible = true
	ray_cast.enabled = true


func stop_shooting() -> void:
	tick_timer.stop()
	shoot_timer.start()
	dial.stop_rotating()
	dial.visible = false
	velocity = calculate_initial_velicity()
	shoot_timer.start()


func calculate_initial_velicity() -> Vector2:
	if ray_cast.is_colliding():
		var aim_direction = (ray_cast.get_collision_point() - global_position).normalized()
		return aim_direction * SPEED
	return Vector2.ZERO


func _on_shoot_timer_timeout() -> void:
	ray_cast.enabled = false
	timer_called = false


func _on_tick_timer_timeout() -> void:
	tick_audio.play()


func _on_ball_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("NotWall"):
		hit_wall_audio.play()
