extends Node

const MAIN_SCENE_GROUP_NAME := "main_scene"

enum MainScene {
	MAIN_MENU,
	CONTAINERS_LEVEL,
	PLATFORMS_LEVEL,
}

const SCENE_PATHS := {
	MainScene.MAIN_MENU: "res://src/elements/ui/menus/main_menu.tscn",
	MainScene.CONTAINERS_LEVEL: "res://src/elements/levels/containers_level.tscn",
	MainScene.PLATFORMS_LEVEL: "res://src/elements/levels/platforms_level.tscn",
}

var last_loaded_scene_path: String


func _ready():
	for scene in SCENE_PATHS:
		var path = SCENE_PATHS[scene]
		assert(ResourceLoader.exists(path), "scene path doesn't exist: '%s'" % path)


func switch_to(scene: MainScene):
	var path = SCENE_PATHS[scene]
	__switch_to_scene_at(path)
	last_loaded_scene_path = path


func reload_current_scene():
	__switch_to_scene_at(last_loaded_scene_path)


func __switch_to_scene_at(path: String):
	self.get_tree().call_group(MAIN_SCENE_GROUP_NAME, "queue_free")
	var node: Node = load(path).instantiate()
	node.add_to_group(MAIN_SCENE_GROUP_NAME)
	self.get_tree().root.add_child(node)


func go_to_main_menu():
	switch_to(MainScene.MAIN_MENU)


func quit():
	self.get_tree().quit()
