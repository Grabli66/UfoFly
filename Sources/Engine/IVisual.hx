import kha.graphics2.Graphics;

/*
*	Класс визуального объекта
*/
interface IVisual {
	/*
	*	Рисует визуальный элемент
	*/
	function render(g: Graphics):Void;	
}