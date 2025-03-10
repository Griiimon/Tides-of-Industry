class_name UIUtils



static func add_label(control: Control, text: String, color: Color= Color.WHITE, horizontal= HORIZONTAL_ALIGNMENT_LEFT, min_size: Vector2= Vector2.ZERO)-> Label:
	var label= Label.new()
	label.text= text
	label.add_theme_color_override("font_color", color)
	label.horizontal_alignment= horizontal
	label.custom_minimum_size= min_size
	control.add_child(label)
	return label


static func add_labels(control: Control, texts: Array[String], color: Color= Color.WHITE, horizontal= HORIZONTAL_ALIGNMENT_LEFT, min_size: Vector2= Vector2.ZERO):
	for text in texts:
		add_label(control, text, color, horizontal, min_size)


static func add_empty(control: Control):
	var label= Label.new()
	control.add_child(label)
	return label


static func add_texture(control: Control, texture: Texture2D):
	var texture_rect:= TextureRect.new()
	texture_rect.texture= texture
	control.add_child(texture_rect)
	return texture_rect


static func add_button(control: Control, text: String, on_pressed= null, args: Array= [])-> Button:
	var button= Button.new()
	button.text= text
	if on_pressed:
		if args.is_empty():
			button.pressed.connect(on_pressed)
		else:
			button.pressed.connect(on_pressed.bindv(args))

	control.add_child(button)
	return button


static func add_timer(node: Node, time: float, one_shot: bool= true, auto_start: bool= false, callback= null)-> Timer:
	var timer= Timer.new()
	timer.wait_time= time
	timer.one_shot= one_shot
	timer.autostart= auto_start
	if callback:
		timer.timeout.connect(callback)
	node.add_child(timer)
	return timer


static func free_children(node: Node):
	for child in node.get_children():
		node.remove_child(child)
		child.queue_free()
