import kha.FastFloat;

/*
*	Геометрический объект
*/
interface IGeometry {
	/*
	*	Двигает объект
	*/
	function move(x: FastFloat, y: FastFloat):Void;
	/*
	*	Вращает объект
	*/
	function rotate(deg: FastFloat):Void;
	/*
	*	Изменяет размер объекта
	*/
	function scale(x: FastFloat, y: FastFloat):Void;
	/*
	*	Возвращает ширину объекта
	*/
	function getWidth():Int;
	/*
	*	Возвращает высоту объекта
	*/
	function getHeight():Int;
}