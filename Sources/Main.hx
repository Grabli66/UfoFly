package;

import kha.System;
import kha.Assets;
import kha.Color;
import kha.FastFloat;

class UfoApp extends Game {
	public static inline var WINDOW_WIDTH = 1024;
	public static inline var WINDOW_HEIGHT = 768;	
	
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
			//addScene('menu', new MenuScene());
			addScene('game', new GameScene());
			setScene('game');					
		});		
	}
}

class Main {		
	public static function main() {
		new UfoApp().run();										
	}
}
