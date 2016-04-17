package;

import kha.System;

class Main {
	public static inline var WINDOW_WIDTH = 1024;
	public static inline var WINDOW_HEIGHT = 768;
	
	public static inline var WORK_WIDTH = 2732;
	public static inline var WORK_HEIGHT = 2048;
	
	public static function main() {
		System.init("Ufo Fly", WINDOW_WIDTH, WINDOW_HEIGHT, function () {
			Game.init(WORK_WIDTH, WORK_HEIGHT, function() {				
				Game.addScene('menu', new MenuScene());
				Game.addScene('game', new GameScene());
				Game.switchScene('game');				
			});			
		});
	}
}
