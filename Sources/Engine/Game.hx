package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Image;
import kha.Color;
import kha.Scaler;
import kha.Assets;
import kha.FastFloat;

class Game {
	private static var backbuffer: Image;	
	private static var scenes: Map<String, Scene>;
	private static var currentScene: Scene;
	
	private static var onReadyCall: Void -> Void; 
	private static var lock = false; 
	
	private static var lastTime: FastFloat;
	
	private function new() {}
	
	public static function init(w: Int, h: Int, onReady: Void->Void) {
		scenes = new Map<String, Scene>();
		lastTime = 0;		
		onReadyCall = onReady;
		lock = true;
		backbuffer = Image.createRenderTarget(w, h);
		Assets.loadEverything(loadFinish);						
	}	
	
	private static function loadFinish() {		
		lock = false;		
		onReadyCall();		
		System.notifyOnRender(render);
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
