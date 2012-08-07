package demo 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import statsystem.inventory.Item;
	import statsystem.inventory.ItemStack;
	import statsystem.StatSystem;
	
	/**
	 * ...
	 * @author alex larioza
	 */
	public class Hud extends Entity 
	{
		private var inventory:Text;
		private var stats:Text;
		private var targetStats:Text;
		private var console:Text;
		private var messages:Array;
		
		public function Hud() 
		{
			super(0, 0);
			
			inventory = new Text("", 340, 0);
			stats = new Text("", 340, 110);
			targetStats = new Text("", 340, 230);
			console = new Text("", 0, 110);
			messages = ["", "", "", "", ""];
			
			graphic = new Graphiclist(inventory, stats, targetStats, console);
		}
		
		override public function added():void 
		{
			super.added();
			
			updateHud();
		}
		
		public function updateHud():void 
		{
			super.update();
			
			var i:uint;
			
			inventory.text = "--inventory--\n";
			for (i = 0; i < GameWorld.player.inventory.size; i++) {
				var itemstack:ItemStack = GameWorld.player.inventory.getBySlot(i);
				if (itemstack != null) {
					inventory.text += (i+1) + ". " + itemstack.item.name + " (" + itemstack.count + ")\n";
				} else {
					inventory.text += (i+1) + ".\n";
				}
			}
			
			console.text = "--message console--\n";
			for (i = 0; i < messages.length; i++) {
				console.text += messages[i] + "\n";
			}
			
			var s:StatSystem = GameWorld.player.stats;
			stats.text = "--stats--\n" + 
			"level: " + s.getStat("level").valueTotal + "\n" +
			"exp: " + s.getStat("experience").valueTotal + "/" + s.getStat("experience").maxValueTotal + "\n" +
			"hp: " + s.getStat("health").valueTotal + "/" + s.getStat("health").maxValueTotal + "\n" +
			"damage: " + s.getStat("damage").valueTotal + "\n" +
			"accuracy: " + s.getStat("accuracy").valueTotal + "\n" +
			"armor: " + s.getStat("armor").valueTotal;
			
			targetStats.text = "--target stats--\n";
			if (GameWorld.player.target != null) {
				s = GameWorld.player.target.stats;
				targetStats.text += "hp: " + s.getStat("health").valueTotal + "/" + s.getStat("health").maxValueTotal + "\n" +
				"damage: " + s.getStat("damage").valueTotal + "\n" +
				"accuracy: " + s.getStat("accuracy").valueTotal + "\n" +
				"armor: " + s.getStat("armor").valueTotal;
			}
		}
		
		public function addMessage(string:String):void
		{
			for (var i:uint = 0; i < messages.length; i++) {
				messages[i] = messages[i + 1];
			}
			messages[messages.length - 1] = string;
			updateHud();
		}
		
	}

}