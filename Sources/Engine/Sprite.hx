import kha.FastFloat;
import kha.graphics2.Graphics;
import kha.math.FastVector2;
import kha.Image;

class Sprite {
	private var position: FastVector2;
	private var rotation: FastFloat;
	private var image: Image;
	
	public function new(x, y: FastFloat, image: Image) {
		position = new FastVector2(x,y);
		rotation = 0;
		this.image = image;		 
	}
	
	public function move(x, y: FastFloat) {
		position.x += x;
		position.y += y;
	}
	
	public function update() {}
	
	public function render(g: Graphics) {
		g.pushTranslation(position.x, position.y);
		g.drawImage(image, 0, 0);
		g.popTransformation();
	}
}