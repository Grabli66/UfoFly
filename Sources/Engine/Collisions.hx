import kha.FastVector;
import kha.graphics2.Graphics;

class CollisionShape {
	private var origin: FastVector;	
	public function testCollision(shape: CollisionShape): CollisionShape {}
	
	public function drawDebug(g: Graphics) {}		
}

class RectangleShape extends CollisionShape {
	public override function testCollision(shape: CollisionShape): CollisionShape {
		
	}
}

class CircleShape extends CollisionShape {
	public override function testCollision(shape: CollisionShape): CollisionShape {
		
	}
}