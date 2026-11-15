extends Node

signal MagUpdate(bullet_count: int, mag_size: int)
signal KillPlayer()

func SwitchScene(SceneToSwitch:PackedScene):
	get_tree().change_scene_to_packed(SceneToSwitch)
