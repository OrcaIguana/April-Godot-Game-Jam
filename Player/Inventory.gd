extends TextureButton

func _on_hover():
	$ColorRect.visible = true
	$GridContainer.visible = true

func _on_exit():
	$ColorRect.visible = false
	$GridContainer.visible = false
