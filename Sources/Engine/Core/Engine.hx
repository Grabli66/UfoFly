package;

import kha.System;
import kha.Color;
import kha.Image;
import kha.Framebuffer;
import kha.graphics2.Graphics;
import kha.math.FastVector2;
import kha.FastFloat;
import kha.Scheduler;
import kha.Scaler;

/*
*	Движок
*/
class Engine {
	// Цвет для очистки экрана
	private static var clearColor = Color.Black;
	// Буффер для рисования
	private static var backbuffer: Image;
	// Визульные объекты
	private static var visuals = new Array<Visual>();
	// Обработчики логики
	private static var controllers = new Array<Controller>();
	// Таймауты	
	private static var timeouts = new Array<TimeoutData>();
	// Предыдущее время, для расчета дельты
	private static var lastTime: FastFloat = Scheduler.time();	
	//	Сцены
	private static var scenes = new Map<String, Scene>();
	// Текущая сцена
	private static var currentScene: Scene;
	// Состояние игры
	private static var engineState: EngineState;
	// Менеджер ресурсов
	public static var assets: AssetManager;
	/*
	*	Инициализирует менеджеры
	*/
	private static function initManagers() {
		assets = new AssetManager();
	}
	/*
	*	Создает окно для игры	
	*/
	public static function createWindow(name: String, width: Int, height: Int, onComplete: Void->Void) {
		System.init({
			title: name,
			width: width,
			height: height
		},  function () {
			initManagers();			 							
			onComplete();
		});
	}
	/*
	*	Устанавливает состояние движка
	*/
	public static function setState(state: EngineState) {
		engineState = state;
	}
	/*
	*	Инициализирует буффер для рисования
	*/
	public static function initBackbuffer(width: Int, height: Int) {
		backbuffer = Image.createRenderTarget(width, height);
	} 	
	/*
	*	Запускает рисование объектов
	*/
	public static function startRender() {
		System.notifyOnRender(render);
	}	
	/*
	*	Возвращает свободный визуальный объект
	*/
	public static function recycleVisual(image: Image) {
		for (vis in visuals) {
			if (!vis.getUsed()) return vis;
		}
		
		var vis = new Visual(image);
		visuals.push(vis);
		return vis;
	}
	/*
	*	Возвращает ширину рабочей области
	*/
	public static function getWidth() : Int {
		return backbuffer.width;
	}	
	/*
	*	Возвращает высоту рабочей области
	*/
	public static function getHeight() : Int {
		return backbuffer.height;
	}	
	/*
	*	Возвращает центр рабочей области 
	*/
	public static function getCenter() : FastVector2 {
		return new FastVector2(getWidth() / 2, getHeight() / 2);
	}	
	/*
	*	Возвращает соотношение сторон рабочей области
	*/
	public static function getAspect(): FastFloat {
		return getWidth() / getHeight();
	}
	/*
	*	Засекает таймаут
	*/
	public static function setTimeout(seconds: Int, onComplete: Void->Void) {
		timeouts.push({
			seconds: seconds,
			onComplete: onComplete
		});		
	}
	/*
	*	Добавляет сцену
	*/
	public static function addScene(name: String, scene: Scene) {
		scenes.set(name, scene);
	}	
	/*
	*	Делает сцену текущей
	*/
	public static function setScene(name: String) {
		if (currentScene != null) currentScene.leaveScene();
		currentScene = scenes.get(name);
		currentScene.enterScene();
		engineState = EngineState.Work;		
	}
	/*
	*	Добавляет контроллер
	*/
	public static function addController(controller: Controller):Void {
		controllers.push(controller);
	}
	/*
	*	Удаляет контроллер
	*/
	public static function removeController(controller: Controller):Void {
		controllers.remove(controller);
	}
	/*
	*	Удаляет все контроллеры
	*/
	public static function clearControllers():Void {
		controllers = new Array<Controller>();
	}
	/*
	*	Обновляет логику игры
	*/
	private static function update() {
		// Получает дельту
		var currentTime = Scheduler.time();
		var dt = currentTime - lastTime;
		lastTime = currentTime;		
		
		// Обрабатывает таймауты				
		for (tm in timeouts) {			
			tm.seconds -= dt;												
			if (tm.seconds <= 0) {
				tm.onComplete();				
				timeouts.remove(tm);
			}
		}
		
		// Обновляет все сцены
		for (scene in scenes) {
			scene.update(dt);
		}
		
		// Обновляет все контроллеры
		for (controller in controllers) {
			controller.update(dt);
		}
	}
	/*
	*	Рисует визуальные объекты
	*/	
	private static function render(framebuffer: Framebuffer) {		
		update();
		
		var g:Graphics = backbuffer.g2;
		g.begin(clearColor);
		
		switch (engineState) {
			case EngineState.None: {}
			case EngineState.AssetManager: {				
				assets.render(g);				
			}			 
			case EngineState.Work: {
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
}