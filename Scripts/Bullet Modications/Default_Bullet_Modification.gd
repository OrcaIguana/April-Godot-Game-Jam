class_name Default_Bullet_Modification
extends Resource

func instantiate(_valf : float = 0, _vali : int = 0, _valb : bool = false):
	pass

func apply_modification(_bullet : Bullet):
	pass

func get_modifier_name() -> String:
	return "Default"

func get_item_tooltip() -> String:
	return "Default tooltip."
