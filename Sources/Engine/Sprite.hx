class Sprite extends Spatial implements IVisual {
	private var image: Image;
	
	public function new(image: Image) {
		this.image = image;
	}
	
	public function getImage():Image {
		return image;
	}
	
	public function setImage(image: Image):Image {
		this.image = image;
	}
	
	/*
	*	Рисует визуальный элемент
	*/
	function render(g: Graphics):Void {
		// Устанавливает трансформации 
		
		// Рисует картинку
		g.drawImage(image, 0, 0);
	}
}