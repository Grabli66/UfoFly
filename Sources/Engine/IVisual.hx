import kha.graphics2.Graphics;
import kha.Image;

/*
*	Класс визуального объекта
*/
interface IVisual extends IGeometry {
	/*
	*	Устанавливает картинку
	*/
	function setImage(image: Image):Void;
	/*
	*	Возвращает картинку
	*/
	function getImage():Image;
	/*
	*	Рисует визуальный элемент
	*/
	function render(g: Graphics):Void;	
}