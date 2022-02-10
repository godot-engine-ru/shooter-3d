tool
extends SceneTree

var idle_count = 1000

func run_idle():
	if (idle_count < 100):
		print("Run idle...", idle_count)
	idle_count -= 1
	if idle_count < 0:
		OS.set_exit_code(0)
		quit()
		OS.kill(OS.get_process_id())

func _init():
	print("Running godot checks...")
	connect("idle_frame", self, "run_idle")
