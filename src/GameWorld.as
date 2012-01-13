package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import flash.utils.getTimer;
	import statsystem.Modifier;
	import statsystem.Stat;
	import statsystem.StatSystem;

	/**
	 * ...
	 * @author Alex Larioza
	 */
	public class GameWorld extends World 
	{
		public static var myStats:StatSystem;
		
		public function GameWorld()
		{
			myStats = new StatSystem();
			
			myStats.addStat(new Stat("health", 80, 100));
			myStats.addStat(new Stat("mana", 20, 20));
			myStats.addStat(new Stat("strength", 5));
			myStats.addStat(new Stat("speed", 10));
		}
		
		override public function begin():void
		{
			super.begin();
			
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed(Key.NUMPAD_ADD)) {
				var stats:Vector.<Stat> = myStats.getAllStats();
				trace("***");
				for each (var stat:Stat in stats) {
					trace("\n" + stat.name + "| current: " + stat.baseValue + "| base max value: " + stat.maxValue);
					
					var statMod:Vector.<Modifier> = stat.getModifiers();
					if (statMod.length > 0) {
						trace(">Modifers");
						for each (var mod:Modifier in statMod) {
							trace(">>" + mod.name + "|" + mod.value);
						}
						trace(">Total Modifier: " + stat.modifierValue);
					}
					if (stat.maxValue == -1) {
						trace("Total Value: " + stat.totalValue);
					} else {
						trace("Max Value: " + stat.totalValue);
					}
				}
			}
			if (Input.pressed(Key.NUMPAD_1)) {
				myStats.getStat("mana").addModifier(new Modifier("Ring of Mana", 10));
				myStats.getStat("health").addModifier(new Modifier("Curse of Dredmor", -50));
				myStats.getStat("strength").addModifier(new Modifier("Gloves of Strength", 10));
			}
			if (Input.pressed(Key.NUMPAD_2)) {
				myStats.getStat("mana").removeModifier("Ring of Mana");
				myStats.getStat("health").removeModifier("Curse of Dredmor");
				myStats.getStat("strength").removeModifier("Gloves of Strength");
			}
		}
		
		override public function render():void 
		{
			super.render();
		}
	}
}