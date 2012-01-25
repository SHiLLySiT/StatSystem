package statsystem.stats 
{
	import flash.utils.Dictionary;
	/**
	 * The base class for stat classes.
	 * @author Alex Larioza
	 */
	public class Stat 
	{
		private var modifiers:Dictionary;
		protected var _name:String;
		protected var _value:Number;
		protected var _maxValue:Number;
		protected var _exp:Number;
		protected var _requiredExp:Vector.<Number>;
		protected var _level:Number;
		protected var _gainPerLevel:Number;
		
		public function Stat(name:String, value:Number, maxValue:Number, gainPerLevel:Number, requiredExp:Vector.<Number>) 
		{
			modifiers = new Dictionary();
			
			_exp = 0;
			_requiredExp = requiredExp;
			_level = 0;
			
			_name = name;
			_value = value;
			_maxValue = maxValue;
			_gainPerLevel = gainPerLevel;
		}
		
		/**
		 * Gets all modifiers and adds their value.
		 * @return The total value of all modifiers.
		 */
		protected function getModifierValue():Number
		{
			var result:Number = 0;
			var v:Vector.<Modifier> = getModifiers();
			
			for each (var modifier:Modifier in v) {
				result += modifier.value;
			}
			
			return result;
		}
		
		/**
		 * Override this; Called after addExp/removeExp to update exp values
		 */
		protected function updateExp():void
		{
			
		}
		
		/**
		 * Override this; Called after add/remove and addModifier/removeModifer to update base value
		 */
		protected function updateValue():void
		{
			
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
			
			updateValue();
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
			
			updateValue();
		}
		
		/**
		 * Adds the given value to the base value of the stat.
		 * @param	value	The value to add.
		 */
		public function add(value:Number):void 
		{ 
			_value += value;
			
			updateValue();
		}
		
		/**
		 * Removes the given value from the base value of the stat.
		 * @param	value	The value to remove.
		 */
		public function remove(value:Number):void
		{
			_value -= value;
			
			updateValue();
		}
		
		/**
		 * Add Exp to stat.
		 * @param	value The value to add.
		 */
		public function addExp(value:Number):void
		{
			_exp += value;
			
			updateExp();
		}
		
		/**
		 * Remove Exp from stat.
		 * @param	value The value to remove.
		 */
		public function removeExp(value:Number):void
		{
			_exp -= value;
			
			updateExp();
		}
		
		/**
		 * Manually set the experience level of the stat. Remember to call setExp() afterwards.
		 * @param	value	The new experience level.
		 */
		public function setLevel(value:Number):void
		{
			_level = value;
		}
		
		/**
		 * Manually set the experience of the stat.
		 * @param	value	The new experience value.
		 */
		public function setExp(value:Number):void
		{
			_exp = value;
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
		 * Returns the max value of the stat.
		 */
		public function get maxValue():Number { return _maxValue; }
		/**
		 * Returns the total value of all modifiers.
		 */
		public function get modifierValue():Number { return getModifierValue(); }
		/**
		 * Returns the current experience.
		 */
		public function get exp():Number { return _exp; }
		/**
		 * Returns the required experience for the current level.
		 */
		public function get requiredExp():Number { return _requiredExp[level]; }
		/**
		 * Returns the current experience level.
		 */
		public function get level():Number { return _level; }
	}

}