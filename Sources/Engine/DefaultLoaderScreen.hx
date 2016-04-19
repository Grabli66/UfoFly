import kha.Color;
import kha.graphics2.Graphics;

class DefaultLoaderScreen extends LoaderScreen {
	private var bgColor:Color = Color.fromValue(0xFF55FF);
	private var progressColor:Color = Color.fromValue(0x0055FF);
	
	public override function render(g: Graphics) {
		g.clear(bgColor);
		g.color = progressColor;
		g.fillRect(100, 100, 200, 200);
	}
}