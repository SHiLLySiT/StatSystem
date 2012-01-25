package statsystem.stats 
{
	/**
	 * Adds a temporary effect to a stat.
	 * @author Alex Larioza
	 */
	public class Modifier 
	{
		private var _name:String;
		private var _value:Number;
		
		/**
		 * Adds a temporary effect to a stat.
		 * @param	name	The name of the modifeir.
		 * @param	value	The amount (negative or positive) that modifier applies to the stat.
		 */
		public function Modifier(name:String, value:Number) 
		{
			_name = name;
			_value = value;
		}
		
		/**
		 * Returns the name of the modifier.
		 */
		public function get name():String { return _name; }
		/**
		 * Returns the value of the modifier.
		 */
		public function get value():Number { return _value; }
	}

}