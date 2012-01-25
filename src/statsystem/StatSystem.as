package statsystem 
{
	import flash.utils.Dictionary;
	import statsystem.stats.*;
	
	/**
	 * Holds a collection of stats.
	 * @author Alex Larioza
	 */
	public class StatSystem 
	{
		private var stats:Dictionary;
		
		/**
		 * Holds a collection of stats.
		 */
		public function StatSystem() 
		{
			stats = new Dictionary();
		}
		
		/**
		 * Adds a stat to the stat system.
		 * @param	stat	The stat object to add.
		 */
		public function addStat(stat:Stat):void
		{
			stats[stat.name] = stat;
		}
		
		/**
		 * Removes a stat by name from the stat system.
		 * @param	name	The name of the stat to remove.
		 * @return	The stat object that was removed.
		 */
		public function removeStat(name:String):Stat
		{
			var stat:Stat = stats[name];
			delete stats[name];
			return stat;
		}
		
		/**
		 * Returns the stat by name from the stat system.
		 * @param	name	The name of the stat to find.
		 * @return The stat object found.
		 */
		public function getStat(name:String):Stat
		{
			return stats[name];
		}
		
		/**
		 * Get all of the stats in the system and pushes them into a vector.
		 * @return A vector of stats.
		 */
		public function getAllStats():Vector.<Stat>
		{
			var result:Vector.<Stat> = new Vector.<Stat>();
			
			for each (var stat:Stat in stats) {
				result.push(stat);
			}
			
			return result;
		}
		
	}

}