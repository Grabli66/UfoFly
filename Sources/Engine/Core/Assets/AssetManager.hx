package;

import kha.graphics2.Graphics;
import kha.Image;

class AssetManager {
    // Окно загрузки ресурсов
	private var loaderScreen: LoaderScreen;
    // Загруженные картинки
    private var images = new Map<String, Image>();
    /*
    *   Конструктор
    */
    public function new() {
        
    }
    /*
	* Загружает ресурсы и отображает окно загрузки
	*/ 
	public function loadAssets(loader: LoaderScreen, onComplete: Void->Void):Void {
		loaderScreen = loader;
		loaderScreen.onComplete(function(loaded: LoadedAssets) {
            for (loadedImage in loaded.images) {
                images[loadedImage.name] = loadedImage.image;
            }
            		
			onComplete();
			Engine.setState(EngineState.Work);
		});
		Engine.setState(EngineState.AssetManager);
		loaderScreen.run();
	}
    /*
    *   Возвращает картинку по названию
    */
    public function getImage(name: String):Image {
        return images[name];
    }
    /*
    *   Работа AssetManager
    */
    public function render(g: Graphics):Void {
        loaderScreen.render(g);
    }
}