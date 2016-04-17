package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Image;
import kha.Color;
import kha.Scaler;
import kha.Assets;
import kha.FastFloat;
import kha.input.Keyboard;
import kha.input.Mouse;
import kha.input.Surface;
import kha.Key;

class Game {
	private static var backbuffer: Image;	
	private static var scenes: Map<String, Scene>;
	private static var currentScene: Scene;
	
	private static var onReadyCall: Void -> Void; 
	private static var lock = false; 
	private static var aspectX: Float = 0;
	private static var aspectY: Float = 0;
	
	private static var lastTime: FastFloat;
	
	private function new() {}
	
	public static function init(w: Int, h: Int, onReady: Void->Void) {
		scenes = new Map<String, Scene>();
		lastTime = Scheduler.time();
		aspectX = Main.WORK_WIDTH / Main.WINDOW_WIDTH;	
		aspectY = Main.WORK_HEIGHT / Main.WINDOW_HEIGHT;	
		onReadyCall = onReady;
		lock = true;
		backbuffer = Image.createRenderTarget(w, h);
		Assets.loadEverything(loadFinish);						
	}	
	
	private static function onKeyDown(key: Key, char: String) {
		currentScene.onKeyDown(key, char);
	}
	
	private static function onMouseDown(button, x, y: Int) {		
		var nx:Int = Math.round(x * aspectX);
		var ny:Int = Math.round(y * aspectY);
		currentScene.onMouseDown(button, nx, ny);		
	}
	
	private static function onTouchDown(index, x, y: Int) {		
		var nx:Int = Math.round(x * aspectX);
		var ny:Int = Math.round(y * aspectY);
		currentScene.onTouchDown(index, nx, ny);		
	}
	
	private static function loadFinish() {		
		lock = false;		
		onReadyCall();
				
		System.notifyOnRender(render);
		Keyboard.get().notify(onKeyDown, null);
		Mouse.get().notify(onMouseDown, null, null, null);
		Surface.get().notify(onTouchDown, null, null);
	}		
	
	public static function addScene(name: String, scene: Scene) {
		scenes.set(name, scene);		
	}
	
	public static function switchScene(name: String) {
		lock = true;
		if (currentScene != null) currentScene.leaveScene();
		currentScene = scenes.get(name);
		currentScene.enterScene();
		lock = false;
	}

	private static function update(): Void {		
		if (lock) return;		
		
		var currentTime = Scheduler.time();
		var delta = currentTime - lastTime;
		lastTime = currentTime;
		
		currentScene.update(delta);
	}

	private static function render(framebuffer: Framebuffer): Void {		
		if (lock) return;		
		
		update();
		
		var g = backbuffer.g2;				
		currentScene.render(g);		
		
		framebuffer.g2.begin();
		Scaler.scale(backbuffer, framebuffer, System.screenRotation);
		framebuffer.g2.end();		
	}
}
