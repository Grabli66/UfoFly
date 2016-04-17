import kha.graphics2.Graphics;
import kha.Color;
import kha.Image;
import kha.Assets;
import kha.FastFloat;
import kha.Key;

class UILayer {
	private var flyUpButton:Sprite;
	private var flyLeftButton:Sprite;
	private var flyRightButton:Sprite;
	
	public function new() {
		var img = Assets.images.up_button;		
		var posY = Main.WORK_HEIGHT - img.height - 20;
		flyUpButton = new Sprite(20, posY, img);
	//	flyLeftButton = new Sprite(0, 0, Assets.images.left_button);
//		flyRightButton = new Sprite(0, 0, Assets.images.right_button);
	}
	
	public function processMouse(x, y: Int) {		
		
	}
	
	public function render(g: Graphics) {
		flyUpButton.render(g);
	}
}

class GameScene extends Scene {
	private var bgColor = Color.fromValue(0x000000);
	private var background: Image;
	private var uiLayer: UILayer;		
	private var player: Player;
	
	public override function enterScene() {
		player = new Player();
		uiLayer = new UILayer();
		background = Assets.images.game_bg;
	}
	
	public override function update(delta: FastFloat) {		
		player.update(delta);
	}
	
	public override function render(g: Graphics) {
		g.begin(bgColor);		
		g.drawImage(background,0,0);		
		player.render(g);
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