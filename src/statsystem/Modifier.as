package statsystem 
{
	/**
	 * ...
	 * @author Alex Larioza
	 */
	public class Modifier 
	{
		private var _name:String;
		private var _value:Number;
		
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