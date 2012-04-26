package demo 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import statsystem.Stat;
	import statsystem.StatSystem;
	
	/**
	 * ...
	 * @author alex larioza
	 */
	public class Player extends Entity 
	{
		private var _stats:StatSystem;
		private var direction:Point;
		
		public function Player(x:Number, y:Number) 
		{
			super(x, y);
			
			//  create new stat system
			_stats = new StatSystem();
			_stats.addStat(new Stat("level", 1, 5));
			_stats.addStat(new Stat("attack", 5, 25));
			_stats.addStat(new Stat("speed", 1, 5));
			_stats.addStat(new Stat("experience", 0, 10));
			
			// when the experience stat's value = maxValue, execute levelUp()
			// you can also set the onFull and onEmpty function in the stat constructor
			_stats.getStat("experience").onFull = levelUp;
			
			type = "player";
			setHitbox(16, 16);
			graphic = new Image(new BitmapData(16, 16));
		}
		
		private function levelUp():void
		{
			// increase stats
			_stats.getStat("level").addValue(1);
			_stats.getStat("attack").addValue(5);
			_stats.getStat("speed").addValue(1);
			
			// set the experience value back to 0
			_stats.getStat("experience").addValue( -_stats.getStat("experience").value);
			// increase the maxValue
			_stats.getStat("experience").addMaxValue(Math.round(_stats.getStat("experience").maxValue * 0.45));
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.check(Key.UP)) {
				y -= _stats.getStat("speed").value;
				direction = new Point(0, -1);
			} else if (Input.check(Key.DOWN)) {
				y += _stats.getStat("speed").value;
				direction = new Point(0, 1);
			} else if (Input.check(Key.LEFT)) {
				x -= _stats.getStat("speed").value;
				direction = new Point(-1, 0);
			} else if (Input.check(Key.RIGHT)) {
				x += _stats.getStat("speed").value;
				direction = new Point(1, 0);
			}
			
			if (Input.pressed(Key.X)) {
				world.add(new Bullet(x, y, direction, _stats.getStat("attack").value));
			}
		}
		
		public function addExp(value:Number):void
		{
			_stats.getStat("experience").addValue(value);
		}
		
		public function get stats():StatSystem { return _stats; }
	}

}