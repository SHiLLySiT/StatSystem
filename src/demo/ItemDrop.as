package demo 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import statsystem.inventory.Item;
	import statsystem.inventory.ItemStack;
	
	/**
	 * ...
	 * @author alex larioza
	 */
	public class ItemDrop extends Entity 
	{
		private const G:Spritemap = new Spritemap(Assets.SPR_TILES, 8, 8);
		public var itemdata:ItemStack;
		private var hasCollided:Boolean;
		
		public function ItemDrop(x:Number, y:Number) 
		{
			super(x, y);
			
			hasCollided = false;
			
			type = "item";
			
			G.add("item", [4]);
			G.play("item");
			
			setHitbox(8, 8);
			graphic = G;
		}
		
		override public function added():void 
		{
			super.added();
			
			var item:String = FP.choose("Iron Sword", "Leather Shield", "Iron Cuirass", "Ring of Accuracy", "Amulet of Health", "Weak Health Potion", "Strong Health Potion");
			itemdata = new ItemStack(GameWorld.DATABASE.getItem(item), 1);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (collide("player", x, y) && !hasCollided) {
				hasCollided = true;
				GameWorld.hud.addMessage("There is a " + itemdata.item.name + " here");
			} else if (!collide("player", x, y)) {
				hasCollided = false;
			}
		}
		
	}

}