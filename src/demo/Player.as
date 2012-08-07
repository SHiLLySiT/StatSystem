package demo 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import statsystem.inventory.Inventory;
	import statsystem.inventory.Item;
	import statsystem.inventory.ItemStack;
	import statsystem.Modifier;
	import statsystem.Stat;
	import statsystem.StatSystem;
	
	/**
	 * ...
	 * @author alex larioza
	 */
	public class Player extends Entity 
	{
		private const SOLIDS:Array = ["level", "monster"];
		private const G:Spritemap = new Spritemap(Assets.SPR_TILES, 8, 8);
		public var stats:StatSystem;
		public var inventory:Inventory;
		public var target:Monster;
		
		public function Player(x:Number, y:Number) 
		{
			super(x, y);
			
			type = "player";
			layer = -100;
			
			stats = new StatSystem();
			stats.addStat(new Stat("health", 10, 10, null, restart));
			stats.addStat(new Stat("armor", 0));
			stats.addStat(new Stat("damage", 2));
			stats.addStat(new Stat("accuracy", 2));
			stats.addStat(new Stat("level", 1));
			stats.addStat(new Stat("experience", 0, 10, levelUp));
			
			inventory = new Inventory(5);
			
			G.add("player", [2]);
			G.play("player");
			
			setHitbox(8, 8);
			graphic = G;
		}
		
		override public function added():void 
		{
			super.added();
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed(Key.LEFT)) {
				move(-8, 0);
			} else if (Input.pressed(Key.RIGHT)) {
				move(8, 0);
			} else if (Input.pressed(Key.UP)) {
				move(0, -8);
			} else if (Input.pressed(Key.DOWN)) {
				move(0, 8);
			}
			
			if (Input.pressed(Key.SPACE)) {
				var e:Entity = collide("item", x, y);
				if (e) {
					var itemstack:ItemStack = (e as ItemDrop).itemdata;
					if (inventory.addItemStack(itemstack) == null) {
						world.remove(e);
						GameWorld.hud.addMessage("You picked up the " + itemstack.item.name);
					} else {
						GameWorld.hud.addMessage("Your inventory is full!");
					}
				}
			}
			
			if (Input.pressed(Key.DIGIT_1)) {
				useItem(0);
			} else if (Input.pressed(Key.DIGIT_2)) {
				useItem(1);
			} else if (Input.pressed(Key.DIGIT_3)) {
				useItem(2);
			} else if (Input.pressed(Key.DIGIT_4)) {
				useItem(3);
			} else if (Input.pressed(Key.DIGIT_5)) {
				useItem(4);
			}
		}
		
		private function useItem(slot:int):void
		{
			var itemstack:ItemStack = inventory.getBySlot(slot);
			if (itemstack != null) {
				if (itemstack.item.type == "weapon") {
					stats.getStat("damage").addModifier(new Modifier(itemstack.item.name, itemstack.item.stats.getStat("damage").value));
					inventory.removeBySlot(slot);
					GameWorld.hud.addMessage("You equip the " + itemstack.item.name + ".");
				} else if (itemstack.item.type == "potion") {
					stats.getStat("health").addValue(itemstack.item.stats.getStat("health").value);
					inventory.removeBySlot(slot);
					GameWorld.hud.addMessage("You drink the " + itemstack.item.name + ".");
				} else if (itemstack.item.type == "armor") {
					stats.getStat("armor").addModifier(new Modifier(itemstack.item.name, itemstack.item.stats.getStat("armor").value));
					inventory.removeBySlot(slot);
					GameWorld.hud.addMessage("You wear the " + itemstack.item.name + ".");
				} else if (itemstack.item.type == "accessory") {
					stats.getStat("accuracy").addModifier(new Modifier(itemstack.item.name, itemstack.item.stats.getStat("accuracy").value));
					stats.getStat("health").addModifier(new Modifier(itemstack.item.name, itemstack.item.stats.getStat("health").value, Stat.MAXVALUE));
					inventory.removeBySlot(slot);
					GameWorld.hud.addMessage("You wear the " + itemstack.item.name + ".");
				}
				GameWorld.hud.updateHud();
			} else {
				GameWorld.hud.addMessage("There is no item in that slot!");
			}
		}
		
		private function move(dx:int, dy:int):void
		{
			var e:Entity;
			e = collideTypes(SOLIDS, x + dx, y + dy);
			if (e) {
				if (e.type == "monster") {
					var damage:int;
					var monster:Monster = (e as Monster);
					target = monster;
					
					// player attack
					if (FP.rand(10) < stats.getStat("accuracy").valueTotal) {
						damage = stats.getStat("damage").valueTotal - monster.stats.getStat("armor").valueTotal;
						damage = (damage < 0) ? 0 : damage;
						GameWorld.hud.addMessage("You hit the monster! -" + damage + " hp");
						monster.stats.getStat("health").addValue( -damage);
					} else {
						GameWorld.hud.addMessage("You miss the monster!");
					}
					
					// monster attack
					if (monster.stats.getStat("health").valueTotal > 0) {
						if (FP.rand(10) < monster.stats.getStat("accuracy").valueTotal) {
							damage = monster.stats.getStat("damage").value - stats.getStat("armor").valueTotal;
							damage = (damage < 0) ? 0 : damage;
							stats.getStat("health").addValue( -damage);
							GameWorld.hud.addMessage("The monster hits you! -" + damage + " hp");
						} else {
							GameWorld.hud.addMessage("The monster misses you!");
						}
					}
					
				} else if (e.type == "level") {
					GameWorld.hud.addMessage("You can't move there!");
				}
			} else {
				moveTo(x + dx, y + dy, SOLIDS);
			}
		}
		
		public function addItem(itemstack:ItemStack):void
		{
			inventory.addItemStack(itemstack);
			GameWorld.hud.updateHud();
		}
		
		public function levelUp():void
		{
			GameWorld.hud.addMessage("You are now level " + stats.getStat("level").value + "!");
			stats.getStat("level").addValue(1);
			stats.getStat("experience").setValue(0);
			stats.getStat("experience").addMaxValue(10);
		}
		
		public function restart():void
		{
			FP.world = new GameWorld();
		}
		
	}

}