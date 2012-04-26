package demo
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import flash.utils.getTimer;
	import statsystem.*;

	/**
	 * ...
	 * @author Alex Larioza
	 */
	public class GameWorld extends World 
	{
		public var player:Player;
		
		public function GameWorld()
		{
			
		}
		
		override public function begin():void
		{
			super.begin();
			
			add(player = new Player(FP.screen.width / 2, FP.screen.height / 2));
			
			add(new Hud());
			
			add(new Enemy(32 + FP.rand(FP.screen.width - 64), 32 + FP.rand(FP.screen.height - 64)));
			add(new Enemy(32 + FP.rand(FP.screen.width - 64), 32 + FP.rand(FP.screen.height - 64)));
			add(new Enemy(32 + FP.rand(FP.screen.width - 64), 32 + FP.rand(FP.screen.height - 64)));
			add(new Enemy(32 + FP.rand(FP.screen.width - 64), 32 + FP.rand(FP.screen.height - 64)));
			add(new Enemy(32 + FP.rand(FP.screen.width - 64), 32 + FP.rand(FP.screen.height - 64)));
		}
		
		override public function update():void 
		{
			super.update();
			
		}
		
		override public function render():void 
		{
			super.render();
		}
	}
}