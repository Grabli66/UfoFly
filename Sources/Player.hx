import kha.Assets;
import kha.Image;
import kha.graphics2.Graphics;
import kha.FastFloat;

class Player {
	private static inline var GRAVITY:FastFloat = 10;
	private static inline var FLY_UP_IMPULS = 400;
	
	private var playerSprite: Sprite;
	private var accelY:FastFloat = 0;		
	
	public function new() {
		var img:Image = Assets.images.ufo;
		var posY = Main.WORK_HEIGHT / 2 - img.height;		
		playerSprite = new Sprite(50, posY, Assets.images.ufo);
	}
	
	public function update(delta: FastFloat) {
		accelY += GRAVITY;
		playerSprite.move(0, accelY * delta);		
		playerSprite.update(delta);
	}
	
	public function render(g: Graphics) {				  
		playerSprite.render(g);
	}
	
	public function flyUp() {
		accelY -= FLY_UP_IMPULS;
	}
}