package statsystem.stats 
{
	/**
	 * A stat that keeps track of the level of a skill, such as player level, strength, speed, or intelligence.
	 * @author Alex Larioza
	 */
	public class LevelStat extends Stat 
	{
		/**
		 * A stat that keeps track of the level of a skill, such as player level, strength, speed, or intelligence.
		 * @param	name	The name of the stat.
		 * @param	startingValue	The starting value.
		 * @param	gainPerLevel	The value gained per level increase.
		 * @param	maxValue	The max value that the stat can achieve, or -1 for no maximum.
		 * @param	requiredExp		A vector of numbers for the required energy per level.
		 */
		public function LevelStat(name:String, startingValue:Number, maxValue:Number = -1, gainPerLevel:Number = 1, requiredExp:Vector.<Number> = null) 
		{
			super(name, startingValue, maxValue, gainPerLevel, requiredExp);
		}
		
		override protected function updateExp():void 
		{
			if (_exp >= _requiredExp[level]) { // if current exp meets or exceeds maxExp
				_exp = _exp - _requiredExp[level]; // set exp to 0, or the difference
				if (_level < _requiredExp.length) {	_level++; } // increase level
				_value += _gainPerLevel; // increase the base value
			} else if (_exp < 0) { // if current exp is negative (for when you remove exp)
				if (_level > 0) { _level--; } // decrease the level
				_exp = _requiredExp[level] - Math.abs(_exp); // set exp to the difference
				_value -= _gainPerLevel; // remove the base value gain for the level
			}
		}
		
		override protected function updateValue():void 
		{
			if (_maxValue != -1 && _value > _maxValue) {
				_value = _maxValue;
			} else if (_value < 0) {
				_value = 0;
			}
		}
	}

}