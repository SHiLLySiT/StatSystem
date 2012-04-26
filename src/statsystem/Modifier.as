package statsystem 
{
	/**
	 * Adds a temporary effect to a stat.
	 * @author Alex Larioza
	 */
	public class Modifier 
	{
		private var _name:String;
		private var _value:Number;
		private var _type:int
		
		/**
		 * Adds a temporary effect to a stat.
		 * @param	name	The name of the modifeir.
		 * @param	value	The amount (negative or positive) that modifier applies to the stat.
		 * @param	type	The value of the stat which this modifier affects - Stat.VALUE or Stat.MAXVALUE.
		 */
		public function Modifier(name:String = "", value:Number = 0, type:int = 0) 
		{
			_name = name;
			_value = value;
			_type = type;
		}
		
		/**
		 * Saves the modifier to a string.
		 */
		public function saveToString():String
		{
			return _name + "," + _value + "," + type;
		}
		
		/**
		 * Loads the modifier from a string.
		 */
		public function loadFromString(string:String):void
		{
			var values:Array = string.split(",");
			_name = values[0];
			_value = values[1];
			_type = values[2];
		}
		
		/**
		 * Returns the name of the modifier.
		 */
		public function get name():String { return _name; }
		/**
		 * Returns the value of the modifier.
		 */
		public function get value():Number { return _value; }
		/**
		 * Returns the type of modifier.
		 */
		public function get type():Number { return _type; }
	}

}