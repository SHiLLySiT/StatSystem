package 
{
	import demo.GameWorld;
	import net.flashpunk.Entity;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	[SWF(width = "560", height = "400")]

	/**
	 * ...
	 * @author Alex Larioza
	 */
	public class Main extends Engine
	{

		public function Main()
		{
			super(560, 400);
			//FP.console.enable();
		}

		override public function init():void
		{
			super.init();

			FP.world = new GameWorld;
		}

	}
}