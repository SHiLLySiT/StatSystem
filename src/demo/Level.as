package demo 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	/**
	 * ...
	 * @author alex larioza
	 */
	public class Level extends Entity 
	{
		private const LEVEL:String = 
		"11111111111111111111111111111111\n" +
		"11111111111111111111111111111111\n" +
		"111111111111111111000?1111111111\n" +
		"1!00?000000000000000@00000000001\n" +
		"11111100?01111111111111110111111\n" +
		"100@0000001?00011?111@0000000@11\n" +
		"1?000?00001000@11011111011101111\n" +
		"1110000@001100111011000011100001\n" +
		"111?@000000000000011?000111?00?1\n" +
		"11111111111111111111111111111111\n" +
		"11111111111111111111111111111111\n" +
		"11111111111111111111111111111111\n";
		
		public var tiles:Tilemap;
		public var grid:Grid;
		
		
		public function Level() 
		{
			super(0, 0);
			
			type = "level";
			
			tiles = new Tilemap(Assets.SPR_TILES, 256, 256, 8, 8);
			grid = new Grid(256, 256, 8, 8);
			
			loadLevel();
		}
		
		private function loadLevel():void
		{
			var row:Array = LEVEL.split("\n"),
				rows:int = row.length,
				col:Array, cols:int, x:int, y:int;
			for (y = 0; y < rows; y ++)
			{
				if (row[y] == '') continue;
				col = row[y].split(""),
				cols = col.length;
				for (x = 0; x < cols; x ++)
				{
					if (col[x] == '') continue;
					if (col[x] == 1) {
						tiles.setTile(x, y, uint(col[x]));
						grid.setTile(x, y, true);
					} else if (col[x] == "!") {
						FP.world.add(GameWorld.player = new Player(x * 8, y * 8));
					} else if (col[x] == "@") {
						FP.world.add(new Monster(x * 8, y * 8));
					} else if (col[x] == "?") {
						FP.world.add(new ItemDrop(x * 8, y * 8));
					}
				}
			}
			
			graphic = tiles;
			mask = grid;
		}
		
	}

}