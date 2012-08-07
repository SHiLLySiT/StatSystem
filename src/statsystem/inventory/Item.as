package statsystem.inventory  
{
	import statsystem.*;
	/**
	 * The base item class. Extend this for your own projects.
	 * @author alex larioza
	 */
	public class Item 
	{
		private var _name:String;
		private var _type:String;
		private var _stack:int;
		private var _stats:StatSystem;
		
		/**
		 * Creates a new item.
		 * @param	name	The name of the new item
		 * @param	type	The type of item
		 * @param	stack	The max stackable amount of the item
		 */
		public function Item(name:String, type:String = "", stack:int = -1) 
		{
			_name = name;
			_type = type;
			_stack = stack;
			
			_stats = new StatSystem();
		}
		
		/**
		 * Gets the statsystem of this item.
		 */
		public function get stats():StatSystem { return _stats; }
		/**
		 * Gets the max stack of this item.
		 */
		public function get stack():int { return _stack; }
		/**
		 * Gets the name of this item.
		 */
		public function get name():String { return _name; }
		/**
		 * Gets the item type
		 */
		public function get type():String { return _type; }
	}

}