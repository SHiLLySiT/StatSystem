package statsystem.stats 
{
	import flash.utils.Dictionary;
	/**
	 * A stat that measures an attribute, such as health, mana, or stamina levels. 
	 * @author Alex Larioza
	 */
	public class MeterStat extends Stat
	{
		/**
		 * A stat that measures an attribute, such as health, mana, or stamina levels.
		 * @param	name	The name of the stat.
		 * @param	startingValue	The starting value.
		 * @param	startingMaxValue	The starting max value.
		 * @param	gainPerLevel	The value to increase the max value by, per level.
		 * @param	requiredExp		A vector of numbers for the required energy per level.
		 */
		public function MeterStat(name:String, startingValue:Number, startingMaxValue:Number, gainPerLevel:Number, requiredExp:Vector.<Number> = null) 
		{
			super(name, startingValue, startingMaxValue, gainPerLevel, requiredExp);
		}
		
		override protected function updateExp():void 
		{
			if (_exp >= _requiredExp[level]) { // if current exp meets or exceeds maxExp
				_exp = _exp - _requiredExp[level]; // set exp to 0, or the difference
				if (_level < _requiredExp.length) { _level++; } // increase level
				_maxValue += _gainPerLevel; // increase the max value
			} else if (_exp < 0) { // if current exp is negative (for when you remove exp)
				if (_level > 0) { _level--; } // decrease the level
				_exp = _requiredExp[level] - Math.abs(_exp); // set exp to the difference
				_maxValue -= _gainPerLevel; // remove the gain for the level
				
			}
		}
		
		override protected function updateValue():void 
		{
			if (_value > _maxValue + getModifierValue()) {
				_value = maxValue + getModifierValue();
			} else if (_value < 0) {
				_value = 0;
			}
		}
	}

}