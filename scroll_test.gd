extends Control

@onready var scroll_container:ScrollContainer = $ScrollContainer

const SCROLL_SPEED:float = 200.0

var joy_value:float

func _input(event):
	if event is InputEventJoypadMotion:
		if event.axis == JOY_AXIS_LEFT_Y:
			if abs(event.axis_value) > 0.1:
				joy_value = event.axis_value
			else:
				joy_value = 0.0


func _process(delta):
	if joy_value != 0.0:
		var scroll_value:int = int( scroll_container.get_v_scroll() + (joy_value * SCROLL_SPEED * delta) )
		scroll_container.set_v_scroll( clamp(scroll_value, 0.0, scroll_container.get_v_scroll_bar().get_max()) )
