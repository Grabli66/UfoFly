import kha.System;
import kha.FastFloat;
import kha.math.FastVector2;
import kha.graphics2.Graphics;
import kha.Framebuffer;
import kha.Scaler;
import kha.Image;
import kha.Color;
import kha.Scheduler;

enum AppState {
	None;  // Ничего не происходит
	Loader; // Происходит загрузка ресурсов
	Work; // Обычная работа
}

class Game {
	public static inline var DEFAULT_WINDOW_NAME = "Game";
	public static inline var DEFAULT_WINDOW_WIDTH = 1024;
	public static inline var DEFAULT_WINDOW_HEIGHT = 768;
	
	private static var gameApp: Game;
	
	private var appState: AppState;	
	private var backbuffer: Image;
	private var bgColor:Color = Color.fromValue(0x000000);
	private var loaderScreen: LoaderScreen;
	
	private var lastTime: FastFloat = Scheduler.time();	
	private var timeouts = new Array<TimeoutData>();
	private var scenes = new Map<String, Scene>();
	private var currentScene: Scene;
	
	/*
	*	Возвращает текущее приложение
	*/
	public static function getApp(): Game {
		return gameApp;
	}
	
	/*
	*	Возвращает ширину рабочей области
	*/
	public function getWidth() : Int {
		return backbuffer.width;
	}
	
	/*
	*	Возвращает высоту рабочей области
	*/
	public function getHeight() : Int {
		return backbuffer.height;
	}
	
	/*
	*	Возвращает центр рабочей области 
	*/
	public function getCenter() : FastVector2 {
		return new FastVector2(getWidth() / 2, getHeight() / 2);
	}
	
	/*
	*	Возвращает соотношение сторон рабочей области
	*/
	public function getAspect(): FastFloat {
		return getWidth() / getHeight();
	}
	
	/*
	*	Засекает таймаут
	*/
	public function setTimeout(seconds: Int, onComplete: Void->Void) {
		timeouts.push({
			seconds: seconds,
			onComplete: onComplete
		});		
	}
	
	public function new() {	
		gameApp = this;	
	}
	
	/*
	*	Запускает работу приложения
	*/ 
	public function run() {
		var configOptions = {
			windowName: DEFAULT_WINDOW_NAME,
			windowWidth: DEFAULT_WINDOW_WIDTH,
			windowHeight: DEFAULT_WINDOW_HEIGHT
		};
		 
		onConfig(configOptions);
		
		System.init(configOptions.windowName, configOptions.windowWidth, configOptions.windowHeight, function () {
			var bufferOptions = {				
				bufferWidth: System.pixelWidth,
				bufferHeight: System.pixelHeight
			}; 			
			onChooseBufferSize(bufferOptions);			
			backbuffer = Image.createRenderTarget(bufferOptions.bufferWidth, bufferOptions.bufferHeight);
			onReady();
			System.notifyOnRender(render);
		});
	}
	
	/*
	*	Добавляет сцену
	*/
	public function addScene(name: String, scene: Scene) {
		scenes.set(name, scene);
	}
	
	/*
	*	Делает сцену текущей
	*/
	public function setScene(name: String) {
		currentScene = scenes.get(name);
		appState = AppState.Work;
	}
	
	public function update() {
		// Получает дельту
		var currentTime = Scheduler.time();
		var delta = currentTime - lastTime;
		lastTime = currentTime;		
		
		// Обрабатывает таймауты				
		for (tm in timeouts) {			
			tm.seconds -= delta;												
			if (tm.seconds <= 0) {				
				tm.onComplete();				
				timeouts.remove(tm);
			}
		}
		
		switch (appState) {
			case AppState.None: return;
			case AppState.Loader: {				
			}			 
			case AppState.Work: {
				currentScene.update(delta);
			}			 
		}
	}
			
	public function render(framebuffer: Framebuffer) {
		update();
		
		var g:Graphics = backbuffer.g2;
		g.begin();
		
		switch (appState) {
			case AppState.None: {
			}
			case AppState.Loader: {				
				loaderScreen.render(g);				
			}			 
			case AppState.Work: {
				currentScene.render(g);
			}			 
		}
		
		g.end();
		
		framebuffer.g2.begin();		
		Scaler.scale(backbuffer, framebuffer, System.screenRotation);
		framebuffer.g2.end();	
	}
	
	/*
	* Загружает ресурсы и отображает окно загрузки
	*/ 
	public function loadAssets(loader: LoaderScreen, onComplete: Void->Void) {
		loaderScreen = loader;
		loaderScreen.onComplete(onComplete);
		appState = AppState.Loader;
		loaderScreen.run();
	}
	
	/*
	*	Вызывается при выборе размера буффера
	*/
	public function onChooseBufferSize(options: BufferSizeOptions) {}
	
	
	/*
	* Абстрактрый метод для переопределения конфигурации
	*/ 
	public function onConfig(config: AppOptions) {}
	
	/*
	* Вызывается когда окно готово для работы
	*/	
	public function onReady() {}
}