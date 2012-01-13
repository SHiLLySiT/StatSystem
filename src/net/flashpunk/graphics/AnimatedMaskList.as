package net.flashpunk.graphics
{
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.FP;

	public class AnimatedMaskList 
	{
		// this is where we store each PixelMask
		// so to access frame x's mask, we just do mask = animatedMaskList.pixelmask[x];
		public var pixelmasks:Array = new Array();
		
		// constructor takes the same bitmap as your spritemap, and needs to know frame width & height
		public function AnimatedMaskList(bitmap:BitmapData, frameWidth:uint = 1, frameHeight:uint = 1) 
		{
			var rect:Rectangle = new Rectangle(0, 0, frameWidth, frameHeight);
			var x:uint = 0;
			var y:uint = 0;
			var width:uint = bitmap.width;
			var height:uint = bitmap.height;
			var origin:Point = new Point(0, 0);
			
			var index:uint = 0;
			
			while (y < height)
			{			
				while (x < width)
				{
				    var frame:BitmapData = new BitmapData(frameWidth, frameHeight);
					frame.copyPixels(bitmap, rect, origin, null, null, true);	
					frame.copyChannel(bitmap, rect, origin, BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
					pixelmasks[index] = new Pixelmask(frame);

					x += frameWidth;
					rect.x = x;
					index += 1;
				}
				x = 0;
				y += frameHeight;
				rect.y = y;
			}
		}
		
	}

}