import kha.graphics2.Graphics;
import kha.FastFloat;
import kha.Assets;

class Asteroid {
	private var speed = 40; 
	
	private var asteroid: Sprite;
		
	public function new() {
		asteroid = new Sprite(Main.WORK_WIDTH - 200, 0, Assets.images.asteroid);
	}
	
	public function update(delta: FastFloat) {
		asteroid.move(-speed * delta, 0);
		asteroid.update(delta);
	}
	
	public function render(g: Graphics) {
		asteroid.render(g);	
	}
}