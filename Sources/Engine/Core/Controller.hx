import kha.FastFloat;
/*
*   Контроллер обладающий логикой
*/
class Controller {
    // Контроллеры
    private var controllers = new Array<Controller>();
    // Родитель
    private var parent: Controller;
    /*
    *   Возвращает родителя
    */
    public inline function getParent():Controller {
        return parent;
    }
    /*
    *   Устанавливает родителя
    */
    public inline function setParent(parent: Controller):Void {
        this.parent = parent;
    }
    /*
    *   Добавляет контроллер
    */
    public inline function addController(controller: Controller):Void {
        controllers.push(controller);
    }
    /*
    *   Удаляет контроллер
    */
    public inline function removeController(controller: Controller):Void {
        controllers.remove(controller);
    }
    /*
    *   Удаляет все контроллеры
    */
    public inline function clearControllers():Void {
        controllers = new Array<Controller>();
    }
    /*
    *   Обладает логикой
    */
    public function update(dt: FastFloat):Void {
        for (controller in controllers) {
            controller.update(dt);
        }
    }
}