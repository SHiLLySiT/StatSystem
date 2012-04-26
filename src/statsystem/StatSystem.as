package statsystem 
{
	import flash.utils.Dictionary;
	
	/**
	 * Holds a collection of stats.
	 * @author Alex Larioza
	 */
	public class StatSystem 
	{
		private var stats:Dictionary;
		private var _length:int;
		
		/**
		 * Holds a collection of stats.
		 */
		public function StatSystem() 
		{
			stats = new Dictionary();
			_length = 0;
		}
		
		/**
		 * Adds a stat to the stat system.
		 * @param	stat	The stat object to add.
		 */
		public function addStat(stat:Stat):void
		{
			stats[stat.name] = stat;
			_length++;
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
			_length--;
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
		
		/**
		 * Saves the statsystem to a string.
		 */
		public function saveToString():String 
		{
			var str:String = "";
			
			var i:uint = 1;
			for each (var stat:Stat in stats) {
				str += stat.saveToString();
				if (i != _length) { str += "\n"; }
				i++;
			}
			
			return str;
		}
		
		/**
		 * Loads the statsystem from a string.
		 */
		public function loadFromString(string:String):void
		{
			// split initial string
			var values:Array = string.split("\n");
			for (var i:uint = 0; i < values.length; i++) {
				var stat:Stat = new Stat();
				stat.loadFromString(values[i]);
				addStat(stat);
			}
		}
		
		/**
		 * The number of stats in the stat system.
		 */
		public function get length():int { return _length; }
	}

}