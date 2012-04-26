package demo 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import statsystem.StatSystem;
	
	/**
	 * ...
	 * @author alex larioza
	 */
	public class Hud extends Entity 
	{
		private var text:Text;
		
		public function Hud() 
		{
			super(0, 0);
			
			text = new Text("");
			
			graphic = text;
		}
		
		override public function update():void 
		{
			super.update();
			
			var stats:StatSystem = (world as GameWorld).player.stats;
			text.text = "LVL:" + stats.getStat("level").value + "\nEXP:" + stats.getStat("experience").value + "/" + stats.getStat("experience").maxValue + "\nATK:" + stats.getStat("attack").value + "\nSPD:" + stats.getStat("speed").value
		}
		
	}

}