import kha.graphics2.Graphics;
import kha.Image;

/*
*	Класс визуального объекта
*/
class Visual extends Object2d {
	// Отображаемая картинка
	private var image:Image;
	// Используется ли объект
	private var used:Bool;
	
	public function new(image: Image) {
		this.image = image;
	}
	/*
	*	Устанавливает используется ли объект
	*/	
	public function setUsed(used: Bool) {
		this.used = used; 		
	}
	/*
	*	Возвращает используется ли объект
	*/
	public function getUsed():Bool {
		return used;
	}
	/*
	*	Устанавливает картинку
	*/
	public function setImage(image: Image):Void {
		this.image = image;
	}
	/*
	*	Возвращает картинку
	*/
	public function getImage():Image {
		return image;
	}
	/*
	*	Рисует визуальный элемент
	*/
	public function render(g: Graphics):Void {
		var pos = getPos();
		g.pushTranslation(pos.x, pos.y);		
		g.drawImage(image, 0, 0);
		g.popTransformation();
	}	
}