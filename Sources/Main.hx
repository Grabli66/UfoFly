package;

import kha.System;
import kha.Assets;
import kha.Color;
import kha.FastFloat;

class UfoApp extends Game {
	public static inline var WINDOW_WIDTH = 1024;
	public static inline var WINDOW_HEIGHT = 768;	
	
	private var sprite: Sprite;
	
	public override function onConfig(config: AppOptions) {
		config.windowWidth = WINDOW_WIDTH;
		config.windowHeight = WINDOW_HEIGHT;		
	}
	
	public override function onChooseBufferSize(options: BufferSizeOptions) {
		options.bufferWidth = WINDOW_WIDTH;
		options.bufferHeight = WINDOW_HEIGHT;
	}
	
	public override function onReady() {
		loadAssets(new DefaultLoaderScreen({
			useResolutionFolders: true,
			delayAfter: 2,
			images : ['game_bg', 'asteroid', 'ufo']
		}), function() {
			//addScene('menu', new Scene());
			//addScene('game', new Scene());
			//setScene('game');
			
			sprite = new Sprite(Assets.images.ufo_1024x768);
			
			Engine.notifyUpdate(function(dt: FastFloat) {
			//	visual.move(10 * dt, 10 * dt);
			});						
		});		
	}
}

class Main {		
	public static function main() {
		new UfoApp().run();										
	}
}
