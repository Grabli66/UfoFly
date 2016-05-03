package;

import kha.System;
import kha.FastFloat;
import kha.math.FastVector2;
import kha.graphics2.Graphics;
import kha.Framebuffer;
import kha.Scaler;
import kha.Image;
import kha.Color;
import kha.Scheduler;

class Game {
	// Название окна по-умолчанию
	public static inline var DEFAULT_WINDOW_NAME = "Game";
	// Ширина окна по-умолчанию
	public static inline var DEFAULT_WINDOW_WIDTH = 1024;
	// Высота окна по-умолчанию
	public static inline var DEFAULT_WINDOW_HEIGHT = 768;	
	/*
	*	Конструктор
	*/
	public function new() {			
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
		Engine.createWindow(configOptions.windowName, configOptions.windowWidth, configOptions.windowHeight, function() {
			var bufferOptions = {				
				bufferWidth: System.windowWidth(),
				bufferHeight: System.windowHeight()
			}; 			
			onChooseBufferSize(bufferOptions);
			Engine.initBackbuffer(bufferOptions.bufferWidth, bufferOptions.bufferHeight);
			onReady();
			Engine.startRender();
		});				
	}	
	/*
	*	Добавляет сцену
	*/
	public function addScene(name: String, scene: Scene) {
		Engine.addScene(name, scene);
	}
	
	/*
	*	Делает сцену текущей
	*/
	public function setScene(name: String) {
		Engine.setScene(name);		
	}			
	/*
	* Загружает ресурсы и отображает окно загрузки
	*/ 
	public function loadAssets(loader: LoaderScreen, onComplete: Void->Void) {
		Engine.assets.loadAssets(loader, onComplete);
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