extends Area



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_Area_body_entered(body):
	if "Player" in body.name:
		Global.score += 5
		var new_dialog = Dialogic.start('Conversation')
		add_child(new_dialog)

