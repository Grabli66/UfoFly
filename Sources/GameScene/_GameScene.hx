import kha.graphics2.Graphics;
import kha.Color;
import kha.Image;
import kha.Assets;
import kha.FastFloat;
import kha.Key;
import kha.math.FastMatrix3;

class GameScene extends Scene {
	private var bgColor = Color.fromValue(0x000000);
	private var background: Image;
	private var uiLayer: UILayer;		
	private var player: Player;
	private var cameraMatrix: FastMatrix3;
	
	private var asteroid: Asteroid;
	
	public override function enterScene() {
		player = new Player();
		uiLayer = new UILayer();
		background = Assets.images.game_bg;
		asteroid = new Asteroid();
		cameraMatrix = FastMatrix3.identity();		
	}
	
	public override function update(delta: FastFloat) {
		cameraMatrix = cameraMatrix.multmat(FastMatrix3.translation(-player.getSpeed() * delta,0));				
		player.update(delta);
		asteroid.update(delta);
	}
	
	public override function render(g: Graphics) {
		g.begin();		
		g.drawImage(background,0,0);			
		
		g.pushTransformation(cameraMatrix);
		player.render(g);
		asteroid.render(g);
		g.popTransformation();
		uiLayer.render(g);
		g.end();
	}
	
	public override function onKeyDown(key: Key, char: String) {
		player.flyUp();
	}
	
	public override function onMouseDown(button, x, y: Int) {			
		uiLayer.processMouse(x, y);
	}
	
	public override function onTouchDown(index, x, y: Int) {
		player.flyUp();
	}
}