import kha.Assets;
import kha.Image;
import kha.graphics2.Graphics;

class Player {
	private var playerSprite: Sprite;	
	
	public function new() {
		playerSprite = new Sprite(0, 0, Assets.images.ufo);
	}
	
	public function update() {
		playerSprite.move(1,0);		
		playerSprite.update();
	}
	
	public function render(g: Graphics) {
				  
		playerSprite.render(g);
	}
}