package statsystem 
{
	import flash.utils.Dictionary;
	/**
	 * The base class for stat classes.
	 * @author Alex Larioza
	 */
	public class Stat 
	{
		/**
		 * Affects the value of the stat.
		 */
		public static const VALUE:int = 0;
		/**
		 * Affects the maxValue of the stat.
		 */
		public static const MAXVALUE:int = 1;
		
		private var modifiers:Dictionary;
		private var _name:String;
		private var _value:Number;
		private var _maxValue:Number;
		private var _onFull:Function;
		private var _onEmpty:Function;
		
		/**
		 * 
		 * @param	name	Name of the stat.
		 * @param	value	Starting value.
		 * @param	maxValue	Starting maxValue, 0 for no limit.
		 * @param	onFull	Function to execute when value equals maxValue.
		 * @param	onEmpty	Function to execute when value equals 0.
		 */
		public function Stat(name:String = "", value:Number = 0, maxValue:Number = 0, onFull:Function = null, onEmpty:Function = null) 
		{
			modifiers = new Dictionary();
			
			_name = name;
			_value = value;
			_maxValue = maxValue;
			_onEmpty = onEmpty;
			_onFull = onFull;
		}
		
		/**
		 * Gets all modifiers and adds their value.
		 * @return The total value of all modifiers.
		 */
		protected function getModifierValue(type:int):Number
		{
			var result:Number = 0;
			var v:Vector.<Modifier> = getModifiers();
			
			for each (var modifier:Modifier in v) {
				if (modifier.type == type) { result += modifier.value; }
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
		 * Sets the value of the stat.
		 * @param	value The new value.
		 */
		public function setValue(value:Number):void
		{
			if (value >= _maxValue) { // if greater than max
				_value = _maxValue;
				_onFull();
			} else if (value <= 0) { // if less than zero
				_value = 0;
				_onEmpty();
			} else {
				_value = value; // else set to value
			}
		}
		
		/**
		 * Sets the maxValue of the stat. Does not allow a negative value.
		 * @param	value The new value.
		 */
		public function setMaxValue(value:Number):void
		{
			_maxValue = (value > 0) ? value : 0;
			_value = (_value > _maxValue) ? _maxValue : _value; // if value is larger than the new max value, scale it
		}
		
		/**
		 * Adds the given value to the value of the stat.
		 * @param	value	Use positive to add value and negative to subtract value.
		 */
		public function addValue(value:Number):void 
		{
			if (_value + value > _value) {             // if positive
				if (_maxValue > 0) {                       // if max value has a limit
					if (_value != _maxValue) {             // if value does not already equal maxValue
						if (_value + value >= _maxValue) { // if new value is greater than maxValue, set to maxValue
							_value = maxValue;
							if (_onFull != null) _onFull();
						} else {
							_value += value;               // else, just add the value
						}
					}
				} else {                                  // if maxValue is 0 (or in otherwords, has no limit
					_value += value;
				}
			} else {                                   // if negative
				if (_value != 0) {                     // if value does not already equal 0
					if (_value + value <= 0) {         // if new value is less than 0, set to 0.
						_value = 0;
						if (_onEmpty != null) _onEmpty();
					} else {
						_value += value;               // else, just add the value
					}
				}
			}
		}
		
		/**
		 * Adds the given value to the maxValue of the stat.
		 * @param	value	Use positive to add value and negative to subtract value.
		 */
		public function addMaxValue(value:Number):void
		{
			_maxValue += value;
			if (_value > _maxValue) { _value = _maxValue; } // if current value exceed the new maxValue, set to new maxValue
		}
		
		/**
		 * Saves the stat to a string.
		 */
		public function saveToString():String 
		{ 
			var str:String = _name + "," + _value + "," + _maxValue;
			
			for each (var modifier:Modifier in modifiers) {
				str += ";" + modifier.saveToString();
			}
			
			return str;
		}
		
		/**
		 * Loads the stat from a string.
		 */
		public function loadFromString(string:String):void
		{
			// split initial string
			var values:Array = string.split(";");
			// split and use first element as stat values
			var stat:Array = values[0].split(",");
			_name = stat[0];
			_value = stat[1];
			_maxValue = stat[2];
			// then for each of the following elements as modifiers
			for (var i:uint = 1; i < values.length; i++) {
				var modifier:Modifier = new Modifier();
				modifier.loadFromString(values[i]);
				addModifier(modifier);
			}
		}
		
		/**
		 * Returns the name of the stat.
		 */
		public function get name():String { return _name; }
		/**
		 * Returns the total value of the stat.
		 */
		public function get valueTotal():Number { return _value + getModifierValue(VALUE); }
		/**
		 * Returns the base value of the stat without modifiers.
		 */
		public function get value():Number { return _value; }
		/**
		 * Returns the total modifier value affecting value.
		 */
		public function get valueModifiers():Number { return getModifierValue(VALUE); }
		/**
		 * Returns the total maxValue of the stat.
		 */
		public function get maxValueTotal():Number { return _maxValue + getModifierValue(MAXVALUE); }
		/**
		 * Returns the base maxValue without modifiers.
		 */
		public function get maxValue():Number { return _maxValue; }
		/**
		 * Returns the total modifier value affecting maxValue.
		 */
		public function get maxValueModifiers():Number { return getModifierValue(MAXVALUE); }
		/**
		 * Sets the function to execute when value equals maxValue.
		 */
		public function set onFull(funct:Function):void {  _onFull = funct; }
		/**
		 * Sets the function to execute when value equals 0.
		 */
		public function set onEmpty(funct:Function):void {  _onEmpty = funct; }
	}

}