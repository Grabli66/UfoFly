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
	// Название окна по-умолчанию
	public static inline var DEFAULT_WINDOW_NAME = "Game";
	// Ширина окна по-умолчанию
	public static inline var DEFAULT_WINDOW_WIDTH = 1024;
	// Высота окна по-умолчанию
	public static inline var DEFAULT_WINDOW_HEIGHT = 768;
	
	// Текущая игра
	private static var gameApp: Game;
	// Состояние игры
	private var appState: AppState;
	// Буффер на котором всё рисуется	
	private var backbuffer: Image;	
	// Окно загрузки ресурсов
	private var loaderScreen: LoaderScreen;	
	// Предыдущее время, для расчета дельты
	private var lastTime: FastFloat = Scheduler.time();
	// Таймауты	
	private var timeouts = new Array<TimeoutData>();
	//	Сцены
	private var scenes = new Map<String, Scene>();
	// Текущая сцена
	private var currentScene: Scene;	
	// Контроллеры
	private var controllers = new Array<IController>();
	// Визульные элементы
	private var visuals = new Array<IVisual>();
	
	/*
	*	Конструктор
	*/
	public function new() {	
		gameApp = this;	
	}
	
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
	
	/*
	*	Добавляет визуальный элемент
	*/
	public function addVisual(visual: IVisual) {
		
	}
	
	/*
	*	Добавляет удаляет визуальный элемент
	*/
	public function removeVisual(visual: IVisual) {
		
	}
	
	/*
	*	Добавляет контроллер
	*/
	public function addController(controller: IController) {
		controllers.push(controller);
	}
	
	/*
	*	Удаляет контроллер
	*/
	public function removeController(controller: IController) {
		controllers.remove(controller);
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
				// Обновляет контроллеры
				for (controller in controllers) {
					controller.update(delta);
				}
			}			 
		}
	}
			
	/*
	*	Рисует визуальные элементы
	*/
	public function render(framebuffer: Framebuffer) {
		update();
		
		var g:Graphics = backbuffer.g2;
		g.begin();
		
		switch (appState) {
			case AppState.None: {}
			case AppState.Loader: {				
				loaderScreen.render(g);				
			}			 
			case AppState.Work: {
				for (visual in visuals) {
					visual.render(g);
				}
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