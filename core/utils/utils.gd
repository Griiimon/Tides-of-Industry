class_name Utils


static func signed_number(value)-> String:
	return str(value) if value < 0 else str("+", value)
