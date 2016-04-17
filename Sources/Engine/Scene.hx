import kha.graphics2.Graphics;
import kha.FastFloat;
import kha.Key;

class Scene {
	public function new() {}	
	public function enterScene() {}	
	public function leaveScene() {}	
	public function update(delta: FastFloat) {}	
	public function render(g: Graphics) {}	
	public function onKeyDown(key: Key, char: String) {}	
	public function onMouseDown(button, x, y: Int) {}
	public function onTouchDown(index, x, y: Int) {}
}