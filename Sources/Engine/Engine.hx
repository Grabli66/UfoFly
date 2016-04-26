import kha.System;
import kha.Image;

class Engine {
	// Буффер для рисования
	private static var backbuffer: Image;
	// Визульные объекты
	private static var visuals = Array<IVisual>();	
	/*
	*	Создает окно для игры	
	*/
	public static function createWindow(name: String, width: Int, height: Int, onComplete: Void->Void) {
		
	}	
	/*
	*	Инициализирует буффер для рисования
	*/
	public static function initBackbuffer(width: Int, height: Int) {
		backbuffer = Image.createRenderTarget(bufferOptions.bufferWidth, bufferOptions.bufferHeight);
	} 	
	/*
	*	Добавляет визуальный элемент
	*/
	public static function addVisual(visual: IVisual) {
		
	}	
	/*
	*	Обновляет логику игры
	*/
	private static function update() {
		
	}
	/*
	*	Рисует визуальные объекты
	*/	
	private static function render() {
		update();
		for (visual in visuals) {
			visual.render();
		}
	}
}