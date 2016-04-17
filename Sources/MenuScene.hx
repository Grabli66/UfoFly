import kha.graphics2.Graphics;
import kha.Color;
import kha.FastFloat;

class MenuScene extends Scene {
	private var bgColor = Color.fromValue(0x000000);		
	
	public override function enterScene() {
		
	}
	
	public override function update(delta: FastFloat) {
		
	}
	
	public override function render(g: Graphics) {
		g.begin(bgColor);
		g.end();
	}
}