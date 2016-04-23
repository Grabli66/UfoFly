import kha.FastFloat;

/*
*	Управляет поведением визуальных элементов
*/
interface IController {
	/*
	*	Обновляет логику визуальных объектов
	*/
	function update(dt: FastFloat):Void;
}