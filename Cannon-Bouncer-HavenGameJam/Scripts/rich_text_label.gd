extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Eventbus.MagUpdate.connect(text_change)


func text_change(bullet:int,mag:int):
	self.text = str(bullet) + "/" + str(mag)
