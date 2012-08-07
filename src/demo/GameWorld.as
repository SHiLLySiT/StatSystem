package demo
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import flash.utils.getTimer;
	import statsystem.*;
	import statsystem.inventory.Database;
	import statsystem.inventory.Inventory;
	import statsystem.inventory.Item;
	import statsystem.inventory.ItemStack;

	/**
	 * ...
	 * @author Alex Larioza
	 */
	public class GameWorld extends World 
	{
		[Embed(source = "database.xml", mimeType = "application/octet-stream")]
		private static const RAW_DATABASE:Class;
		public static const DATABASE:Database = new Database(RAW_DATABASE);
		public static var player:Player;
		public static var hud:Hud;
		
		public function GameWorld()
		{
			
		}
		
		override public function begin():void
		{
			super.begin();
			add(new Level());
			add(hud = new Hud());
			hud.addMessage("Welcome to the StatSystem Demo!");
		}
		
		override public function update():void 
		{
			super.update();
			
		}
		
		override public function render():void 
		{
			super.render();
		}
	}
}