import kha.Image;
import kha.FastFloat;

/*
*	Визуальный объект с анимацией и проверкой коллизий
*/
class Sprite implements IVisual {
	// Визуальный объект
	private var visual: Visual;
	
	public function new(image: Image) {		
		visual = Engine.recycleVisual(image);
	}
	/*
    *   Передвигает объект
    */
    public function move(x: FastFloat, y: FastFloat):Void {
		visual.move(x, y);
	}
    /*
    *   Вращает объект
    */
    public function rotate(deg: FastFloat):Void {
		visual.rotate(deg);
	}
    /*
    *   Изменяет масштаб объекта
    */
    public function scale(x: FastFloat, y: FastFloat):Void {
		visual.scale(x, y);
	}
}