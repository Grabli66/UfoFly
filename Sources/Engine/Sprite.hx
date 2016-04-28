import kha.Image;

class Sprite {
	private var visual: Visual;
	
	public function new(image: Image) {		
		visual = Engine.recycleVisual(image);
	}
}