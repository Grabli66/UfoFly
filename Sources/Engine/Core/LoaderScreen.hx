import kha.graphics2.Graphics;
import kha.Color;
import kha.Assets;
import kha.FastFloat;

class LoaderScreen {		
	private var currentIndex: Int = 0;
	private var total: Int = 0;
	private var onCompleteCall: Void->Void;
	
	// Задержка после загрузки всех ресурсов
	private var options: LoaderOptions;	
			
	public function new(options: LoaderOptions) {
		this.options = options;				
		total += options.images.length;
		if (options.delayAfter == null) options.delayAfter = 0;
	}
	
	/*
	*	Возращает название размера буффера. Пример: 1024x768
	*/
	private function getResolutionName(): String {
		return Engine.getWidth() + 'x' + Engine.getHeight();
	}
	
	/*
	*	Проверяет окончание загрузки
	*/
	private function checkComplete() {
		if (currentIndex >= total) {			
			if (onCompleteCall != null) {				
				Engine.setTimeout(options.delayAfter, onCompleteCall);				
			}
		}
	}
	
	/*
	*	Запускает загрузку
	*/
	public function run() {
		var suffix = if (options.useResolutionFolders) getResolutionName() else '';
		
		for (img in options.images) {			
			var name = '${img}_${suffix}';
			Assets.loadImage(name, function(im) {
				currentIndex += 1;
				checkComplete();				
			});
		}
	}
	
	/*
	*	Добавляет обратный вызов при завершении
	*/		
	public function onComplete(callBack: Void->Void) {		
		onCompleteCall = callBack;		
	}		
	
	/*
	* Вызывается при загрузке ресурса.
	*/
	public function onProgress(index, total: Int){
		this.currentIndex = index;
		this.total = total;
	}	
	
	/*
	* Рисует окно загрузки
	*/
	public function render(g: Graphics) {}
}