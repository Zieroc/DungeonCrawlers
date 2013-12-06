package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author ...
	 */
	public class ShiftyvanDam extends FlxSprite
	{
		private var hasSpawned:Boolean;
		private var willSpawn:Boolean;
		private var willRetreat:Boolean;
		private var clickedOn:Boolean;
		private var spawnTime:Number;
		private var stayTime:Number;
		private var timer:Number;
		private static var spawnLevel:int;
		
		public function ShiftyvanDam() 
		{
			loadGraphic(Sources.ImgShifty, true, false, 32, 32);
			addAnimation("standard", [0, 1], 2, true);
			play("standard");
			x = 400;
			y = -40;
			willSpawn = false;
			willRetreat = false;
			timer = 0;
			stayTime = 2;
			spawnTime = Math.floor(Math.random() * 50) + 1;
			hasSpawned = false;
		}
		
		public override function update():void
		{
			super.update();
			
			velocity.y = 0;
			if (willSpawn && y < 0)
			{
				velocity.y = 8;
			}
			else if (willSpawn && y >= 0)
			{
				y = 0;
				willSpawn = false;
			}
			else if (willRetreat && y > -40)
			{
				velocity.y = -8;
				
				if (clickedOn)
				{
					velocity.y = -16;
				}
			}
			else if (willRetreat && y <= -40)
			{
				willRetreat = false;
			}
			
			if (y == 0)
			{
				timer += FlxG.elapsed;
				if (timer > stayTime)
				{
					willRetreat = true;
					timer = 0;
				}
			}
			
			if (y < 0 && !hasSpawned && !willSpawn)
			{
				timer += FlxG.elapsed;
				if (timer > spawnTime)
				{
					willSpawn = true;
					hasSpawned = true;
					timer = 0;
				}
			}
		}
		
		public function retreat():void
		{
			willRetreat = true;
			clickedOn = true;
			willSpawn = false;
		}
		
		public function getClickedOn():Boolean
		{
			return clickedOn;
		}
		
		public static function levelToSpawn(level:int):void
		{
			spawnLevel = level;
		}
		
		public static function getSpawnLevel():int
		{
			return spawnLevel;
		}
	}

}