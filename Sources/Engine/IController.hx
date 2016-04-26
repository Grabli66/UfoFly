import kha.FastFloat;

/*
*	Управляет поведением визуальных элементов. Расширяется с помощью других контроллеров
*/
interface IController {
	/*
	*	Родитель контроллера
	*/
	function setParent(parent: IController):Void;
	/*
	*	Добавляет компонент
	*/
	function addController(controller: IController):Void;
	/*
	*	Удаляет компонент
	*/
	function removeController(controller: IController):Void;
	/*
	*	Обновляет логику визуальных объектов и компонентов
	*/
	function update(dt: FastFloat):Void;
}