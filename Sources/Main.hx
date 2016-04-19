package;

import kha.System;
import kha.Assets;

class UfoApp extends GameApp {
	public static inline var WINDOW_WIDTH = 1024;
	public static inline var WINDOW_HEIGHT = 768;
	
	public static inline var WORK_WIDTH = 1024;
	public static inline var WORK_HEIGHT = 768;
	
	public override function onConfig(config: AppOptions) {
		
	}
	
	public override function onReady() {
		loadAssets(new DefaultLoaderScreen());		
	}
}

class Main {		
	public static function main() {
		new UfoApp().run();										
	}
}
