import kha.FastFloat;
import kha.math.FastVector2;

/*
*	Геометрический объект
*/
class Object2d implements IObject2d {
	// Позиция объекта
	private var position = new FastVector2(0,0);
	// Угол поворота
	private var rotation:FastFloat = 0;
	// Масштаб
	private var scaleObj = new FastVector2(1,1);	
	/*
	*	Возвращает позицию объекта
	*/
	public function getPos():FastVector2 {
		return position;		
	}					
	/*
	*	Двигает объект
	*/
	public function move(x: FastFloat, y: FastFloat):Void {
		position.x += x;
		position.y += y;
	}
	/*
	*	Вращает объект
	*/
	public function rotate(deg: FastFloat):Void {
		rotation += deg;
	}
	/*
	*	Изменяет масштаб объекта
	*/
	public function scale(x: FastFloat, y: FastFloat):Void {
		scaleObj.x += x;
		scaleObj.y += y;
	}	
}