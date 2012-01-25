package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import flash.utils.getTimer;
	import statsystem.*;
	import statsystem.stats.*;

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
			
			myStats.addStat(new MeterStat("health", 80, 100, 10));
			myStats.addStat(new MeterStat("mana", 20, 20, 5));
			var levelExp:Vector.<Number> = Vector.<Number>([10, 25, 50, 100, 200, 300, 600, 1200]);
			myStats.addStat(new LevelStat("level", 1, 100, 1, levelExp));
			myStats.addStat(new LevelStat("strength", 5));
			myStats.addStat(new LevelStat("speed", 10));
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
						trace("Total Value: " + (stat.baseValue + stat.modifierValue));
					} else {
						trace("Total (max) Value: " + (stat.maxValue + stat.modifierValue));
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
			var s:Stat = myStats.getStat("level");
			if (Input.pressed(Key.NUMPAD_4)) {
				trace("\nLevel " + s.level + " | " + s.exp + "/" + s.requiredExp);
			}
			if (Input.pressed(Key.NUMPAD_5)) {
				myStats.getStat("level").addExp(10);
				trace("Added 10exp - level " + s.level + " | " + s.exp + "/" + s.requiredExp);
			}
			if (Input.pressed(Key.NUMPAD_6)) {
				myStats.getStat("level").removeExp(10);
				trace("Removed 10exp - level " + s.level + " | " + s.exp + "/" + s.requiredExp);
			}
		}
		
		override public function render():void 
		{
			super.render();
		}
	}
}