package;

import kha.graphics2.Graphics;

class AssetManager {
    // Окно загрузки ресурсов
	private var loaderScreen: LoaderScreen;
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
		loaderScreen.onComplete(function() {			
			onComplete();
			Engine.setState(EngineState.Work);
		});
		Engine.setState(EngineState.AssetManager);
		loaderScreen.run();
	}
    
    /*
    *   Работа AssetManager
    */
    public function render(g: Graphics):Void {
        loaderScreen.render(g);
    }
}