import kha.FastFloat;

/*
*   Интерфейс 2d объекта
*/
interface IObject2d {
    /*
    *   Передвигает объект
    */
    function move(x: FastFloat, y: FastFloat):Void;
    /*
    *   Вращает объект
    */
    function rotate(deg: FastFloat):Void;
    /*
    *   Изменяет масштаб объекта
    */
    function scale(x: FastFloat, y: FastFloat):Void;
}