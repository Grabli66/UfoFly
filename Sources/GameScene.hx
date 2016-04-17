import kha.graphics2.Graphics;
import kha.Color;
import kha.Image;
import kha.Assets;

class GameScene extends Scene {
	private var bgColor = Color.fromValue(0x000000);
	private var background: Image;		
	private var player: Player;
	
	public override function enterScene() {
		player = new Player();
		background = Assets.images.game_bg;
	}
	
	public override function update() {		
		player.update();
	}
	
	public override function render(g: Graphics) {
		g.begin(bgColor);		
		g.drawImage(background,0,0);
		player.render(g);
		g.end();
	}
}