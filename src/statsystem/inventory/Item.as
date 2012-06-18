package statsystem.inventory  
{
	import statsystem.Stat;
	import statsystem.StatSystem;
	/**
	 * The base item class. Extend this for your own projects.
	 * @author alex larioza
	 */
	public class Item 
	{
		private var _name:String;
		private var _stats:StatSystem;
		
		/**
		 * Creates a new item.
		 * @param	name	The name of the new item
		 * @param	stack	The max stackable amount of the item
		 */
		public function Item(name:String, stack:int = -1) 
		{
			_name = name;
			
			_stats = new StatSystem();
			_stats.addStat(new Stat("stack", stack));
		}
		
		/**
		 * Gets the statsystem of this item.
		 */
		public function get stats():StatSystem { return _stats; }
		/**
		 * Gets the max stack of this item.
		 */
		public function get stack():int { return _stats.getStat("stack").value; }
		/**
		 * Gets the name of this item.
		 */
		public function get name():String { return _name; }
	}

}