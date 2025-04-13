extends Button

signal on_press

var id = 1

func send_signal():
	on_press.emit(id)
	print("Signal Sent")
