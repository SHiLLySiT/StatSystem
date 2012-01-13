package statsystem 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Alex Larioza
	 */
	public class Stat 
	{
		private var modifiers:Dictionary;
		private var _name:String;
		private var _value:Number;
		private var _maxValue:Number;
		
		public function Stat(name:String, startingValue:Number, maxValue:Number = -1) 
		{
			modifiers = new Dictionary();
			
			_name = name;
			_value = startingValue;
			_maxValue = maxValue;
		}
		
		/**
		 * Gets all modifiers and adds their value.
		 * @return The total value of all modifiers.
		 */
		private function getModifierValue():Number
		{
			var result:Number = 0;
			var v:Vector.<Modifier> = getModifiers();
			
			for each (var modifier:Modifier in v) {
				result += modifier.value;
			}
			
			return result;
		}
		
		/**
		 * Returns modifier objects, if any.
		 * @return A vector of the modifiers.
		 */
		public function getModifiers():Vector.<Modifier>
		{
			var result:Vector.<Modifier> = new Vector.<Modifier>();
			
			for each (var modifier:Modifier in modifiers) {
				result.push(modifier);
			}
			
			return result;
		}
		
		/**
		 * Adds a modifier to the stat.
		 * @param	modifier	The modifier object to add.
		 */
		public function addModifier(modifier:Modifier):void
		{
			modifiers[modifier.name] = modifier;
			
			// The purpose of the following check is to keep the current value
			// less than the max value in the case that a modifier negatively affects the stat.
			// This will only occur if there is a max value.
			if (_maxValue != -1) {
				if (_value > _maxValue + modifier.value) {
					_value = _maxValue + modifier.value;
				}
			}
		}
		
		/**
		 * Removes a modifier by name from the stat.
		 * @param	name 	The name of the modifier to remove.
		 * @return Modifier that was removed.
		 */
		public function removeModifier(name:String):Modifier
		{
			var modifier:Modifier = modifiers[name];
			delete modifiers[name];
			return modifier;
		}
		
		/**
		 * Adds the given value to the base value of the stat.
		 * @param	value	The value to add.
		 */
		public function add(value:Number):void 
		{ 
			if (_maxValue == -1) { // if there no max value...
				_value += value; // just add the new value
			} else { // if there is a max value...
				if (_value + value <= _maxValue + getModifierValue()) { // check that the new value is within the max value + modifier(s)
					_value += value; // then add the new value
				}
			}
		}
		
		/**
		 * Removes the given value from the base value of the stat.
		 * @param	value	The value to remove.
		 */
		public function remove(value:Number):void
		{
			if (_value - value >= 0) {
				_value -= value;
			}
		}
		
		/**
		 * Returns the name of the stat.
		 */
		public function get name():String { return _name; }
		/**
		 * Returns the base (or actual) value of the stat.
		 */
		public function get baseValue():Number { return _value; }
		/**
		 * Returns the total value of all modifiers.
		 */
		public function get modifierValue():Number { return getModifierValue(); }
		/**
		 * If there is not a max value, returns the actual value plus the total modifier value.
		 * If there is a max value, returns the max value plus the total modifier value.
		 */
		public function get totalValue():Number { return (_maxValue == -1) ? _value + getModifierValue() : _maxValue + getModifierValue(); }
		/**
		 * Returns the max value of the stat or -1 if there is none.
		 */
		public function get maxValue():Number { return _maxValue; }
	}

}