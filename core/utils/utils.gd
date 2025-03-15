class_name Utils


static func signed_number(value)-> String:
	if value is String: return value
	return str(value) if value < 0 else str("+", value)
