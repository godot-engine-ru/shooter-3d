tool
extends SceneTree

var idle_count = 800

func run_idle():
	var result
	if (idle_count < 1):
		print("Run complete...")
	idle_count -= 1
	OS.delay_usec(20000)
	if idle_count < 0:
		print("Run finished...")
		OS.set_exit_code(0)
		quit()
		for k in range(500):
			OS.delay_usec(20000)
		result = OS.kill(OS.get_process_id())
		assert(result == OK)

func _init():
	print("Running godot checks...")
	var result = connect("idle_frame", self, "run_idle")
	assert(result == OK)
