package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author ...
	 */
	public class PlaceableTile extends FlxSprite
	{
		private var index:int; //What tile this represents
		
		public function PlaceableTile(index:int) 
		{
			this.index = index;
			if (index >= 0)
			{
				loadGraphic(Sources.ImgMap, false, false, 32, 32);
				
				addAnimation("0", [0]);
				addAnimation("1", [1]);
				addAnimation("2", [2]);
				addAnimation("3", [3]);
				addAnimation("4", [4]);
				addAnimation("5", [5]);
				addAnimation("6", [6]);
				addAnimation("7", [7]);
			}
			else
			{
				loadGraphic(Sources.ImgScoreMap, false, false, 32, 32);
				
				addAnimation("-1", [1]);
				addAnimation("-2", [2]);
			}
		}
		
		public function getIndex():int 
		{
			return index;
		}
		
		override public function update():void
		{
			super.update();
			play("" + index);
		}
	}

}