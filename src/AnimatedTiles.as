package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author ...
	 */
	public class AnimatedTiles extends FlxSprite
	{
		private var index:int
		
		public function AnimatedTiles(index:int, x:int, y:int) 
		{
			this.index = index;
			
			switch(index)
			{
				case 3:
					loadGraphic(Sources.ImgDownArrow, true, false, 32, 32);
					addAnimation("idle", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 15, true);
					break;
				case 4:
					loadGraphic(Sources.ImgUpArrow, true, false, 32, 32);
					addAnimation("idle", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 15, true);
					break;
			}
			
			this.x = x;
			this.y = y;
		}
		
		override public function update():void
		{
			super.update();
			play("idle");
		}
		
		public function getIndex():int
		{
			return index;
		}
		
	}

}