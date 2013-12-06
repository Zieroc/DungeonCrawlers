package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author ...
	 */
	public class Player extends FlxSprite
	{
		private var isTop:Boolean;
		private var speed:int;
		private var dying:Boolean;
		private var pitDeath:Boolean;
		private var moveLane:Boolean;
		private var targetLane:int;
		private var direction:int;
		private var deathTileX:int;
		private var monsterDeath:Boolean;
		private var lane:int;
		
		public function Player(isTop:Boolean) 
		{
			loadGraphic(Sources.ImgTopPlayer, true, true, 32, 32);
			this.isTop = isTop;
			if (!isTop)
			{
				facing = LEFT;
			}
			speed = 48;
			lane = 3;
			
			addAnimation("standard", [0, 1, 2, 3, 4, 5, 6, 7], 10, true);
			addAnimation("idle", [4]);
			
			pitDeath = false;
			monsterDeath = false;
			dying = false;
			moveLane = false;
			targetLane = 0;
			direction = 0;
		}
		
		override public function update():void
		{
			super.update();
			if (!dying)
			{
				play("standard");
				if (isTop)
				{
					velocity.x = speed;
				}
				else
				{
					velocity.x = -speed;
				}
				
				if (moveLane)
				{
					if (direction == 0)
					{
						if (y > targetLane)
						{
							velocity.y = -100;
						}
						else
						{
							y = targetLane;
							moveLane = false;
							velocity.y = 0;
						}
					}
					else
					{
						if (y < targetLane)
						{
							velocity.y = 100;
						}
						else
						{
							y = targetLane;
							moveLane = false;
							velocity.y = 0;
						}
					}
				}
			}
			else
			{
				if (pitDeath)
				{
					if (x % 32 == 0)
					{
						velocity.x = 0;
					}
					else
					{
						if (isTop)
						{
							if (x < deathTileX)
							{
								velocity.x = 48;
							}
							else
							{
								x = deathTileX;
								velocity.x = 0;
							}
						}
						else
						{
							if (x > deathTileX)
							{
								velocity.x = -48;
							}
							else
							{
								x = deathTileX;
								velocity.x = 0;
							}
						}
					}
					
					if (scale.x > 0.1)
					{
						scale.x -= 0.03;
						scale.y -= 0.03;
						alpha -= 0.03;
					}
					else
					{
						kill();
					}
				}
				else if (monsterDeath)
				{
					velocity.x = 0;
					//play("idle");
					
					if (alpha > 0)
					{
						alpha -= 0.05;
					}
					else
					{
						kill();
					}
				}
				
			}
		}
		
		public function setSpeed(speed:int):void 
		{
			this.speed = speed;
		}
		
		public function getSpeed():int
		{
			return speed;
		}
		
		public function fall(causeTile:int):void
		{
			dying = true;
			pitDeath = true;
			deathTileX = causeTile;
		}
		
		public function killed():void
		{
			dying = true;
			monsterDeath = true;
		}
		
		public function switchLane(dir:int):void
		{
			moveLane = true;
			direction = dir;
			if (dir == 0)
			{
				targetLane = y - 32;
				lane--;
			}
			else
			{
				targetLane = y + 32;
				lane++;
			}
		}
		
		public function getMoveLane():Boolean
		{
			return moveLane;
		}
		
		public function getTargetLane():int
		{
			return targetLane;
		}
		
		public function getDirection():int
		{
			return direction;
		}
		
		public function getDying():Boolean
		{
			return dying;
		}
		
		public function getLane():int
		{
			return lane;
		}
	}

}