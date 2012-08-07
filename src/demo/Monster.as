package demo 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import statsystem.Stat;
	import statsystem.StatSystem;
	
	/**
	 * ...
	 * @author alex larioza
	 */
	public class Monster extends Entity 
	{
		private const G:Spritemap = new Spritemap(Assets.SPR_TILES, 8, 8);
		public var stats:StatSystem;
		
		public function Monster(x:Number, y:Number) 
		{
			super(x, y);
			
			type = "monster";
			
			stats = new StatSystem();
			var hp:int = FP.rand(15);
			stats.addStat(new Stat("health", hp, hp, null, destroy));
			stats.addStat(new Stat("armor", FP.rand(5)));
			stats.addStat(new Stat("damage", FP.rand(5)));
			stats.addStat(new Stat("accuracy", FP.rand(8)));
			
			G.add("monster", [3]);
			G.play("monster");
			
			setHitbox(8, 8);
			graphic = G;
		}
		
		public function destroy():void
		{
			GameWorld.player.target = null;
			GameWorld.hud.addMessage("The monster dies! +5 exp");
			GameWorld.player.stats.getStat("experience").addValue(5);
			GameWorld.hud.updateHud();
			world.remove(this);
		}
		
	}

}