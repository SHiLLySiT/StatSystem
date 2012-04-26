package demo 
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import statsystem.Stat;
	import statsystem.StatSystem;
	
	/**
	 * ...
	 * @author alex larioza
	 */
	public class Enemy extends Entity 
	{
		private var stats:StatSystem
		private var text:Text;
		
		public function Enemy(x:Number, y:Number) 
		{
			super(x, y);
			
			stats = new StatSystem();
			// when health = 0, destroy
			stats.addStat(new Stat("health", 25, 25, null, destroy));
			
			text = new Text("HP:" + stats.getStat("health").value, -8, -16);
			addGraphic(text);
			
			type = "enemy";
			setHitbox(16, 16);
			addGraphic(new Image(new BitmapData(16, 16, false, 0xff0000)));
		}
		
		public function setHealth(value:Number):void
		{
			stats.getStat("health").addValue(value);
			text.text = "HP:" + stats.getStat("health").value;
		}
		
		public function destroy():void
		{
			(world as GameWorld).player.addExp(2);
			world.add(new Enemy(32 + FP.rand(FP.screen.width - 64), 32 + FP.rand(FP.screen.height - 64)));
			world.remove(this);
		}
	}

}