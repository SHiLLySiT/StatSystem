package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Alex Larioza
	 */
	public class PL 
	{
		 /**
		 * Returns random number within the specified range
		 * @param min Minimum value.
		 * @param max Maximum value.
		 */
		
		public static function randRange(min:int, max:int):int
		{
			return Math.round(Math.random() * (max - min)) + min;	
		}
		
		public static function arraySum(arr:Array):Number
		{
			var sum:Number = 0;
			for (var i:uint = 0; i < arr.length; i++) {
				sum += arr[i];
			}
			return sum;
		}
		
		public static function arrayMax(arr:Array):int
		{
			var max:Number = 0;
			var index:int = 0;
			for (var i:uint = 0; i < arr.length; i++) {
				if (arr[i] > max) { 
					max = arr[i]; 
					index = i;
				}
			}
			return index;
		}
		
		/**
		 * Moves the entity using polar coordinates
		 * @param	distance	Distance to move (use distance * FP.elapsed for variable time)
		 * @param	direction	Direction to move, in degrees (0 is to the right, ccw)
		 */
		public static function moveDirection(entity:Entity, distance:Number, direction:Number):void
		{
			// Need to convert degrees to radians for sin/cos functions, hence multiplying by Math.PI/180
			entity.x += distance * Math.cos(direction * Math.PI/180);
			entity.y -= distance * Math.sin(direction * Math.PI/180);	// Minus here, because negative is up	
		}
		
		/**
		 * Returns the direction of point(x1,y1) towards point(x2,y2) in degrees
		 */
		public static function pointDirection(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			// This is slightly different than the standard cartesian implementation atan2(x2 - x1, y2 - y1)
			// due to the orientation of the game's coordinate system, where 0,0 is at the upper left
			return (Math.atan2(y1 - y2, x2 - x1) * 180 / Math.PI);
		}
		
	}

}