extends Button

func _process(delta):
	if is_hovered():
		add_font_override("font", theme.get_font("font_hover", self.get_class()))
	else:
		add_font_override("font", theme.get_font("font", self.get_class()))
		
