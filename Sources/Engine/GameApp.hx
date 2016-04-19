import kha.System;
import kha.FastFloat;
import kha.Framebuffer;
import kha.Scaler;
import kha.Image;
import kha.Color;

enum AppState {
	None;  // Ничего не происходит
	Loader; // Происходит загрузка ресурсов
	Work; // Обычная работа
}

class GameApp {
	public static inline var DEFAULT_WINDOW_NAME = "Game";
	public static inline var DEFAULT_WINDOW_WIDTH = 1024;
	public static inline var DEFAULT_WINDOW_HEIGHT = 768;
	
	private var appState: AppState;	
	private var backbuffer: Image;
	private var bgColor:Color = Color.fromValue(0x000000);
	private var loaderScreen: LoaderScreen; 
	
	
	public function new() {		
	}
	
	public function run() {
		var configOptions = {
			windowName: DEFAULT_WINDOW_NAME,
			windowWidth: DEFAULT_WINDOW_WIDTH,
			windowHeight: DEFAULT_WINDOW_HEIGHT
		};
		 
		onConfig(configOptions);
		
		System.init(configOptions.windowName, configOptions.windowWidth, configOptions.windowHeight, function () {
			onReady();
			backbuffer = Image.createRenderTarget(configOptions.windowWidth, configOptions.windowHeight);
			System.notifyOnRender(render);
		});
	}
	
	public function update() {
		switch (appState) {
			case AppState.None: return;
			case AppState.Loader: {
				
			}			 
			case AppState.Work: {
				
			}			 
		}
	}
	
	public function render(framebuffer: Framebuffer) {
		update();
		
		switch (appState) {
			case AppState.None: {
				backbuffer.g2.begin(bgColor);
				backbuffer.g2.end();
			}
			case AppState.Loader: {
				backbuffer.g2.begin();
				loaderScreen.render(backbuffer.g2);
				backbuffer.g2.end();
			}			 
			case AppState.Work: {
				
			}			 
		}			
		
		framebuffer.g2.begin();
		Scaler.scale(backbuffer, framebuffer, System.screenRotation);
		framebuffer.g2.end();	
	}
	
	/*
	* Загружает ресурсы и отображает окно загрузки
	*/ 
	public function loadAssets(loader: LoaderScreen) {
		loaderScreen = loader;
		appState = AppState.Loader;
	}
	
	/*
	* Абстрактрый метод для переопределения конфигурации
	*/ 
	public function onConfig(config: AppOptions) {}
	
	/*
	* Вызывается когда окно готово для работы
	*/	
	public function onReady() {}
}