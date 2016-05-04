package;

import kha.graphics2.Graphics;
import kha.Color;
import kha.Assets;
import kha.FastFloat;
import kha.Image;

/*
*	Экран загрузки ресурсов
*/
class LoaderScreen {
	// Количество загруженных ресурсов		
	private var currentIndex: Int = 0;
	// Всего ресурсов
	private var total: Int = 0;
	// Обратный вызов при загрузке ресурсов
	private var onCompleteCall: LoadedAssets->Void;
	// Загруженные ресурсы
	private var loadedAssets: LoadedAssets;
	// Задержка после загрузки всех ресурсов
	private var options: LoaderOptions;	
			
	public function new(options: LoaderOptions) {
		this.options = options;				
		total += options.images.length;
		if (options.delayAfter == null) options.delayAfter = 0;
		loadedAssets = {
			images: new Array<LoadedImage>()
		};
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
				Engine.setTimeout(options.delayAfter, function() {
					onCompleteCall(loadedAssets);
				});				
			}
		}
	}
	
	/*
	*	Запускает загрузку
	*/
	public function run() {
		var suffix = if (options.useResolutionFolders) getResolutionName() else '';
		
		for (imgName in options.images) {			
			var name = '${imgName}_${suffix}';
			Assets.loadImage(name, function(image) {
				loadedAssets.images.push({
					name: imgName,
					image: image
				});
				currentIndex += 1;
				checkComplete();				
			});
		}
	}
	
	/*
	*	Добавляет обратный вызов при завершении
	*/		
	public function onComplete(callBack: LoadedAssets->Void) {		
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