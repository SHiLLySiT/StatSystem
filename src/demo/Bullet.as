package demo 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author alex larioza
	 */
	public class Bullet extends Entity 
	{
		private var direction:Point;
		private var damage:Number;
		
		public function Bullet(x:Number, y:Number, direction:Point, damage:Number) 
		{
			super(x, y);
			
			this.direction = direction;
			this.damage = damage;
			
			type = "bullet";
			setHitbox(8, 8);
			graphic = new Image(new BitmapData(8, 8));
		}
		
		override public function update():void 
		{
			super.update();
			
			x += direction.x * 20;
			y += direction.y * 20;
			
			var e:Enemy = (collide("enemy", x, y) as Enemy) 
			if (e) {
				e.setHealth( -damage);
				world.remove(this);
			}
		}
		
	}

}