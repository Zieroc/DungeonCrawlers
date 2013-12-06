package  
{
	import org.flixel.FlxRect;
	/**
	 * ...
	 * @author ...
	 */
	public class PickableTile
	{
		private var topTile:PlaceableTile;
		private var bottomTile:PlaceableTile;
		private var bounds:FlxRect;
		
		public function PickableTile(topIndex:int, bottomIndex:int) 
		{
			topTile = new PlaceableTile(topIndex);
			bottomTile = new PlaceableTile(bottomIndex);
			bounds = new FlxRect(0, 0, 32, 64);
			topTile.x = 0;
			bottomTile.x = 0;
			topTile.y = 0;
			bottomTile.y = 0 + 32;
		}
		
		public function getTopTile():PlaceableTile
		{
			return topTile;
		}
		
		public function getBottomTile():PlaceableTile
		{
			return bottomTile;
		}
		
		public function getBounds():FlxRect
		{
			return bounds;
		}
		
		public function setBounds(x:int, y:int):void
		{
			bounds.x = x;
			bounds.y = y;
			
			topTile.x = x;
			bottomTile.x = x;
			topTile.y = y;
			bottomTile.y = y + 32;
		}
	}

}