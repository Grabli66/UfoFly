import kha.Color;
import kha.graphics2.Graphics;

class DefaultLoaderScreen extends LoaderScreen {
	private var bgColor:Color = Color.fromValue(0x20386C);
	private var progressBgColor:Color = Color.fromValue(0xFFddca00);
	private var progressColor:Color = Color.fromValue(0xFF006700);
	private var progressWidth:Int = 600;
	private var progressHeight:Int = 15;	
	private var padding:Int = 3;
	
	public override function render(g: Graphics) {
		g.clear(bgColor);		
		g.color = progressBgColor;	
		var center = Game.getApp().getCenter();
		var width = Game.getApp().getWidth();
		var px = center.x - progressWidth / 2;
		var py = center.y - progressHeight / 2;		
		g.fillRect(px, py, progressWidth, progressHeight);
				
		g.color = progressColor;
		var pbw = (progressWidth - padding * 2) * (currentIndex / total);		
		g.fillRect(px + padding, py + padding, pbw, progressHeight - padding * 2);
	}
}