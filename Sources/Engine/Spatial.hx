import kha.FastFloat;

class Spatial implements IGeometry implements IController {
	private var controllers = new Array<IController>();
	/*
	*	Двигает объект
	*/
	function move(x: FastFloat, y: FastFloat):Void {
		
	}
	/*
	*	Вращает объект
	*/
	function rotate(deg: FastFloat):Void {
		
	}
	/*
	*	Изменяет размер объекта
	*/
	function scale(x: FastFloat, y: FastFloat):Void {
		
	}
	/*
	*	Возвращает ширину объекта
	*/
	function getWidth():Int {
		
	}
	/*
	*	Возвращает высоту объекта
	*/
	function getHeight():Int {
		
	}
	/*
	*	Добавляет компонент
	*/
	public function addController(controller: IController):Void {
		controllers.push(controller);
	}
	/*
	*	Удаляет компонент
	*/
	public removeController(controller: IController):Void {
		controllers.remove(controller);
	}
	/*
	*	Обновляет логику визуальных объектов и компонентов
	*/
	public update(dt: FastFloat):Void {
		for (controller in controllers) {
			controller.update();
		}
	}
}