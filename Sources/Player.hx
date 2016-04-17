import kha.Assets;
import kha.Image;
import kha.graphics2.Graphics;
import kha.FastFloat;

class Player {
	private var playerSprite: Sprite;	
	
	public function new() {
		playerSprite = new Sprite(0, 0, Assets.images.ufo);
	}
	
	public function update(delta: FastFloat) {
		playerSprite.move(200 * delta, 200 * delta);		
		playerSprite.update(delta);
	}
	
	public function render(g: Graphics) {
				  
		playerSprite.render(g);
	}
}