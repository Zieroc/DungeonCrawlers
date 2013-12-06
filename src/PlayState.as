package
{
	import org.flixel.*;
	import org.flixel.system.FlxList;
	import org.flixel.system.FlxTile;
	import com.newgrounds.*;
	
	public class PlayState extends FlxState
	{
		//{ region Variables
		
		private var topPlayer:Player;
		private var bottomPlayer:Player;
		
		private var topScroll:Player;
		private var bottomScroll:Player;
		
		private var topMap:FlxTilemap;
		private var backMap:FlxTilemap;
		private var scoreMap:FlxTilemap;
		
		private var topCamera:FlxCamera;
		private var bottomCamera:FlxCamera;
		
		private var topHud:FlxSprite;
		private var mainHud:FlxSprite;
		
		private var topTile:PlaceableTile;
		private var bottomTile:PlaceableTile;
		
		private var score:Number;
		private var scoreText:FlxText;
		
		private var time:Number = 0;
		private var timeText:FlxText;
		
		private var inventory:Array;
		private var selectedIndex:int;
		private var haveTile:Boolean;
		private var numTiles:int;
		private var swapping:Boolean;
		private var swapButton:FlxSprite;
		private var swapOnCooldown:Boolean;
		private var timeOnCooldown:Number;
		private var timeStartedCooldown:Number;
		
		private var level:int;
		
		private var animatedTiles:Array;
		
		private var shifty:ShiftyvanDam;
		
		private var tiles:FlxGroup;
		private var hoverTiles:FlxGroup;
		private var player:FlxGroup;
		private var hud:FlxGroup;
		
		//} endregion
			
		//{ region Constructor
		
		public function PlayState(level: int):void
		{
			this.level = level;
			this.score = 0;
		}
		
		//} endregion
		
		//{ region Create Method
		
		override public function create():void
		{	
			tiles = new FlxGroup();
			hoverTiles = new FlxGroup();
			player = new FlxGroup();
			hud = new FlxGroup();
			add(tiles);
			add(hoverTiles);
			add(player);
			add(hud);
			
			backMap = new FlxTilemap();
			backMap.loadMap(new Sources.TxtBackMap, Sources.ImgMap, 32, 32);
			backMap.scrollFactor.x = 0;
			backMap.scrollFactor.y = 0;
			tiles.add(backMap);
			
			topMap = new FlxTilemap();
			scoreMap = new FlxTilemap();
			switch(level)
			{
				case 1:
					topMap.loadMap(new Sources.TxtTopMap, Sources.ImgMap, 32, 32);
					scoreMap.loadMap(new Sources.TxtScoreMap, Sources.ImgScoreMap, 32, 32);
					break;
				case 2:
					topMap.loadMap(new Sources.TxtTopMap2, Sources.ImgMap, 32, 32);
					scoreMap.loadMap(new Sources.TxtScoreMap2, Sources.ImgScoreMap, 32, 32);
					break;
				case 3:
					topMap.loadMap(new Sources.TxtTopMap3, Sources.ImgMap, 32, 32);
					scoreMap.loadMap(new Sources.TxtScoreMap3, Sources.ImgScoreMap, 32, 32);
					break;
				case 4:
					topMap.loadMap(new Sources.TxtTopMap4, Sources.ImgMap, 32, 32);
					scoreMap.loadMap(new Sources.TxtScoreMap4, Sources.ImgScoreMap, 32, 32);
					break;
				case 5:
					topMap.loadMap(new Sources.TxtTopMap6, Sources.ImgMap, 32, 32);
					scoreMap.loadMap(new Sources.TxtScoreMap6, Sources.ImgScoreMap, 32, 32);
					break;
				case 6:
					topMap.loadMap(new Sources.TxtTopMap5, Sources.ImgMap, 32, 32);
					scoreMap.loadMap(new Sources.TxtScoreMap5, Sources.ImgScoreMap, 32, 32);
					break;
				case 7:
					topMap.loadMap(new Sources.TxtTopMap8, Sources.ImgMap, 32, 32);
					scoreMap.loadMap(new Sources.TxtScoreMap8, Sources.ImgScoreMap, 32, 32);
					break;
				case 8:
					topMap.loadMap(new Sources.TxtTopMap7, Sources.ImgMap, 32, 32);
					scoreMap.loadMap(new Sources.TxtScoreMap7, Sources.ImgScoreMap, 32, 32);
					break;
				case 9:
					topMap.loadMap(new Sources.TxtTopMap9, Sources.ImgMap, 32, 32);
					scoreMap.loadMap(new Sources.TxtScoreMap9, Sources.ImgScoreMap, 32, 32);
					break;
				case 10:
					topMap.loadMap(new Sources.TxtTopMap10, Sources.ImgMap, 32, 32);
					scoreMap.loadMap(new Sources.TxtScoreMap10, Sources.ImgScoreMap, 32, 32);
					break;
			}
			
			for (var j:int = 0; j < topMap.widthInTiles; j++)
			{
				for (var k:int = 0; k < topMap.heightInTiles; k++)
				{
					if (scoreMap.getTile(j, k) != 0 && topMap.getTile(j, k) != 0)
					{
						scoreMap.setTile(j, k, 0, true);
					}
				}
			}
			
			tiles.add(topMap);
			tiles.add(scoreMap);
			
			topPlayer = new Player(true);
			topPlayer.x = 32;
			topPlayer.y = 128;
			player.add(topPlayer);
			
			bottomPlayer = new Player(false);
			bottomPlayer.x = topMap.width - 64;
			bottomPlayer.y = 480 - 96;
			player.add(bottomPlayer);
			
			topScroll = new Player(true);
			topScroll.x = FlxG.width / 2 - 16;
			topScroll.y = -60;
			player.add(topScroll);
			
			bottomScroll = new Player(false);
			bottomScroll.x = topMap.width - FlxG.width / 2 - 16;
			bottomScroll.y = 600;
			player.add(bottomScroll);
			
			topCamera = new FlxCamera(0, 64, 640, 160, 1);
			bottomCamera = new FlxCamera(0, 320, 640, 160, 1);
			topCamera.setBounds(0, 64, topMap.width, 160);
			bottomCamera.setBounds(0, 320, topMap.width, 160);
			FlxG.addCamera(topCamera);
			FlxG.addCamera(bottomCamera);
			//FlxG.camera.visible = false;
			topCamera.follow(topScroll, FlxCamera.STYLE_LOCKON);
			bottomCamera.follow(bottomScroll, FlxCamera.STYLE_LOCKON);
			
			topHud = new FlxSprite(0, 0, Sources.ImgTopHud);
			hud.add(topHud);
			
			mainHud = new FlxSprite(0, 224, Sources.ImgMainHud);
			hud.add(mainHud);
			
			scoreText = new FlxText(95, 17, 100, score.toString());
			scoreText.setFormat(null, 24, 0x000000, null, 0x000000);
			hud.add(scoreText);
			
			timeText = new FlxText(500, 17, 100, FlxU.formatTime(time));
			timeText.setFormat(null, 24, 0x000000, null, 0x000000);
			hud.add(timeText);
			
			//Hardcode Inventory Tiles
			inventory = new Array();
			numTiles = 0;
			var tile1:PickableTile = new PickableTile(1, 1);
			var tile2:PickableTile = new PickableTile(4, 1);
			var tile3:PickableTile = new PickableTile(3, 1);
			var tile4:PickableTile = new PickableTile(5, 1);
			var tile5:PickableTile = new PickableTile(1, 4);
			var tile6:PickableTile = new PickableTile(1, 3);
			var tile7:PickableTile = new PickableTile(1, 5);
			var tile8:PickableTile = new PickableTile(4, 3);
			var tile9:PickableTile = new PickableTile(3, 4);
			var tile10:PickableTile = new PickableTile(3, 3);
			var tile11:PickableTile = new PickableTile(4, 4);
			var tile12:PickableTile = new PickableTile(1, 1);
			addTileToInventory(tile1);
			addTileToInventory(tile12);
			addTileToInventory(tile2);
			addTileToInventory(tile3);
			addTileToInventory(tile4);
			addTileToInventory(tile5);
			addTileToInventory(tile6);
			addTileToInventory(tile7);
			addTileToInventory(tile8);
			addTileToInventory(tile9);
			addTileToInventory(tile10);
			addTileToInventory(tile11);
			
			
			selectedIndex = -1;
			haveTile = false;
			swapping = false;
			swapOnCooldown = false;
			timeStartedCooldown = 0;
			timeOnCooldown = 0;
			
			swapButton = new FlxSprite(544, 240, Sources.ImgSwapButton);
			hud.add(swapButton);
			
			animatedTiles = new Array();
			
			shifty = new ShiftyvanDam(); //One is created even if not added to prevent null object problems
			if (ShiftyvanDam.getSpawnLevel() == level)
			{
				hud.add(shifty);
			}
			
			FlxG.playMusic(Sources.Mp3Level, 1);
		}
		
		//} endregion
		
		//{ region Update
		
		override public function update():void
		{
			if (topPlayer.alive && bottomPlayer.alive)
			{
				super.update();
				//FlxG.collide(topPlayer, topMap);
				//FlxG.collide(topMap, bottomPlayer);
				
				// if player beats the level
				if (topPlayer.x > topMap.width && bottomPlayer.x < 0)
				{	
					if (time <= 50)
					{
						if (!API.getMedal("Speed Run").unlocked)
						{
							API.unlockMedal("Speed Run");
						}
					}
					if (level == 1)
					{
						if (!API.getMedal("First Floor!").unlocked)
						{
							API.unlockMedal("First Floor!");
						}
					}
					else if (level == 5)
					{
						if (!API.getMedal("Five Floor Run!").unlocked)
						{
							API.unlockMedal("Five Floor Run!");
						}
					}
					else if (level == 10)
					{
						if (!API.getMedal("Dungeon Cleared!").unlocked)
						{
							API.unlockMedal("Dungeon Cleared!");
						}
					}
					
					//if the player has beaten the game
					var timeMul:Number;
					if (time >= 60)
					{
						timeMul = 1;
					}
					else if (time < 60 && time >= 55)
					{
						timeMul = 2;
					}
					else if (time < 55 && time >= 45)
					{
						timeMul = 3;
					}
					else if (time <= 45)
					{
						timeMul = 5;
					}
					FlxG.switchState(new LevelState(level + 1, score, time, timeMul));
				}
				
				if (haveTile || swapping)
				{
					var topMousePos:FlxPoint = FlxG.mouse.getWorldPosition(topCamera);
					var bottomMousePos:FlxPoint = FlxG.mouse.getWorldPosition(bottomCamera);
					if ((FlxG.mouse.screenY > 64 && FlxG.mouse.screenY < 224))
					{
						
						//topCamera.overlapsPoint(topMousePos)
						if (swapping)
						{
							var topIndex:int = topMap.getTile(Math.floor(((bottomPlayer.x - 576) + FlxG.mouse.screenX) / 32), (Math.floor(FlxG.mouse.screenY / 32) * 32 + 256) / 32);
							var bottomIndex:int = topMap.getTile(Math.floor(topMousePos.x / 32), Math.floor(FlxG.mouse.screenY / 32));
							
							if (topIndex == 0)
							{
								var sI:int = scoreMap.getTile(Math.floor(((bottomPlayer.x - 576) + FlxG.mouse.screenX) / 32), (Math.floor(FlxG.mouse.screenY / 32) * 32 + 256) / 32);
								if (sI == 0)
								{
									topIndex = 1;
								}
								else
								{
									topIndex = -sI;
								}
							}
							else if (topIndex == 6)
							{
								topIndex = 7;
							}
							
							if (bottomIndex == 0)
							{
								var sI:int = scoreMap.getTile(Math.floor(topMousePos.x / 32), Math.floor(FlxG.mouse.screenY / 32));
								if (sI == 0)
								{
									bottomIndex = 1;
								}
								else
								{
									bottomIndex = -sI;
								}
							}
							else if (bottomIndex == 7)
							{
								bottomIndex = 6;
							}
							
							if (topTile.getIndex() != topIndex)
							{
								hoverTiles.remove(topTile);
								topTile = new PlaceableTile(topIndex);
								topTile.alpha = 0.4;
								hoverTiles.add(topTile);
							}
							if (bottomTile.getIndex() != bottomIndex)
							{
								hoverTiles.remove(bottomTile);
								bottomTile = new PlaceableTile(bottomIndex);
								bottomTile.alpha = 0.4;
								hoverTiles.add(bottomTile);
							}
						}
						topTile.x = Math.floor(topMousePos.x / 32) * 32;
						topTile.y = Math.floor(FlxG.mouse.screenY / 32) * 32;
						//var distance:int = 0 + topTile.x;
						bottomTile.x = Math.floor((Math.max(0, bottomPlayer.x - 576) + FlxG.mouse.screenX) / 32) * 32;
						bottomTile.y = topTile.y + 256;
					}
					else if ((FlxG.mouse.screenY > 320 && FlxG.mouse.screenY < 480))
					{
						if (swapping)
						{
							var topIndex:int = topMap.getTile(Math.floor(bottomMousePos.x / 32), Math.floor(FlxG.mouse.screenY / 32));
							var bottomIndex:int = topMap.getTile(Math.floor((topPlayer.x - 32) + FlxG.mouse.screenX) / 32, (Math.floor(FlxG.mouse.screenY / 32) * 32 - 256) / 32);
							
							if (topIndex == 0)
							{
								var sI:int = scoreMap.getTile(Math.floor(bottomMousePos.x / 32), Math.floor(FlxG.mouse.screenY / 32));
								if (sI == 0)
								{
									topIndex = 1;
								}
								else
								{
									topIndex = -sI;
								}
							}
							else if (topIndex == 6)
							{
								topIndex = 7;
							}
							
							if (bottomIndex == 0)
							{
								var sI:int = scoreMap.getTile(Math.floor((topPlayer.x - 32) + FlxG.mouse.screenX) / 32, (Math.floor(FlxG.mouse.screenY / 32) * 32 - 256) / 32);
								if (sI == 0)
								{
									bottomIndex = 1;
								}
								else
								{
									bottomIndex = -sI;
								}
							}
							else if (bottomIndex == 7)
							{
								bottomIndex = 6;
							}
							
							if (topTile.getIndex() != topIndex)
							{
								hoverTiles.remove(topTile);
								topTile = new PlaceableTile(topIndex);
								topTile.alpha = 0.4;
								hoverTiles.add(topTile);
							}
							if (bottomTile.getIndex() != bottomIndex)
							{
								hoverTiles.remove(bottomTile);
								bottomTile = new PlaceableTile(bottomIndex);
								bottomTile.alpha = 0.4;
								hoverTiles.add(bottomTile);
							}
						}
						
						bottomTile.x = Math.floor(bottomMousePos.x / 32) * 32;
						bottomTile.y = Math.floor(FlxG.mouse.screenY / 32) * 32;
						//var distance:int = 0 + topTile.x;
						topTile.x = Math.floor((Math.min(topMap.width - 640, topPlayer.x - 32) + FlxG.mouse.screenX) / 32) * 32;
						topTile.y = bottomTile.y - 256;
					}
					else
					{
						topTile.x = -60;
						topTile.y = -60;
						bottomTile.x = -60;
						bottomTile.y = -60;
					}
				}
				
				if (FlxG.mouse.pressed())
				{
					if (haveTile && ((FlxG.mouse.screenY > 64 && FlxG.mouse.screenY < 224) || (FlxG.mouse.screenY > 320 && FlxG.mouse.screenY < 480)))
					{
						FlxG.play(Sources.Mp3Placed, 0.2);
						if (!swapping)
						{
							if (topMap.getTile(Math.floor(topTile.x / 32), Math.floor(topTile.y / 32)) == 7)
							{
								if (topTile.getIndex() != 7)
								{
									score += 25;
									FlxG.play(Sources.Mp3MonsterHurt, 0.5);
								}
							}
							if (topMap.getTile(Math.floor(bottomTile.x / 32), Math.floor(bottomTile.y / 32)) == 6)
							{
								if (bottomTile.getIndex() != 6)
								{
									score += 25;
									FlxG.play(Sources.Mp3MonsterHurt, 0.5);
								}
							}
						}
						topMap.setTile(Math.floor(topTile.x / 32), Math.floor(topTile.y / 32), topTile.getIndex(), true);
						topMap.setTile(Math.floor(bottomTile.x / 32), Math.floor(bottomTile.y / 32), bottomTile.getIndex(), true);
						haveTile = false;
						if (swapping)
						{
							var topScoreIndex:int = scoreMap.getTile(Math.floor(topTile.x / 32), Math.floor(topTile.y / 32));
							var bottomScoreIndex:int = scoreMap.getTile(Math.floor(bottomTile.x / 32), Math.floor(bottomTile.y / 32));
							scoreMap.setTile(Math.floor(bottomTile.x / 32), Math.floor(bottomTile.y / 32), topScoreIndex, true);
							scoreMap.setTile(Math.floor(topTile.x / 32), Math.floor(topTile.y / 32), bottomScoreIndex, true);
							
							swapping = false;
							swapOnCooldown = true;
							timeStartedCooldown = time + FlxG.elapsed;
							swapButton.alpha = 0.4;
						}
						else
						{
							scoreMap.setTile(Math.floor(bottomTile.x / 32), Math.floor(bottomTile.y / 32), 0, true);
							scoreMap.setTile(Math.floor(topTile.x / 32), Math.floor(topTile.y / 32), 0, true);
							removeTileFromInventory(selectedIndex);
						}
						
						if (topTile.getIndex() >= 3 && topTile.getIndex() <= 4)
						{
							animatedTiles.push(new AnimatedTiles(topTile.getIndex(), topTile.x, topTile.y));
							tiles.add(animatedTiles[animatedTiles.length - 1]);
							
						}
						if(bottomTile.getIndex() >= 3 && bottomTile.getIndex() <= 4)
						{
							animatedTiles.push(new AnimatedTiles(bottomTile.getIndex(), bottomTile.x, bottomTile.y));
							tiles.add(animatedTiles[animatedTiles.length - 1]);
						}
						
						topTile.x = -60;
						topTile.y = -60;
						bottomTile.x = -60;
						bottomTile.y = -60;
					}
					else
					{
						for (var i:int = 0; i < inventory.length; i++)
						{
							if (inventory[i].getBounds().overlaps(new FlxRect(FlxG.mouse.screenX, FlxG.mouse.screenY, 8, 8)))
							{
								hoverTiles.remove(topTile);
								hoverTiles.remove(bottomTile);
								topTile = new PlaceableTile(inventory[i].getTopTile().getIndex());
								bottomTile = new PlaceableTile(inventory[i].getBottomTile().getIndex());
								topTile.alpha = 0.4;
								bottomTile.alpha = 0.4;
								hoverTiles.add(topTile);
								hoverTiles.add(bottomTile);
								
								selectedIndex = i;
								haveTile = true;
								i = inventory.length;
								swapping = false;
							}
						}
						if (new FlxRect(swapButton.x, swapButton.y, swapButton.width, swapButton.height).overlaps(new FlxRect(FlxG.mouse.screenX, FlxG.mouse.screenY, 8, 8)))
						{
							if (!swapOnCooldown)
							{
								swapping = true;
								haveTile = true;
								hoverTiles.remove(topTile);
								hoverTiles.remove(bottomTile);
								topTile = new PlaceableTile(3);
								bottomTile = new PlaceableTile(3);
								topTile.alpha = 0.4;
								bottomTile.alpha = 0.4;
								hoverTiles.add(topTile);
								hoverTiles.add(bottomTile);
							}
						}
						if (new FlxRect(shifty.x, shifty.y, shifty.width, shifty.height).overlaps(new FlxRect(FlxG.mouse.screenX, FlxG.mouse.screenY, 8, 8)) && FlxG.mouse.screenY >= 0 && !shifty.getClickedOn())
						{
							if (!API.getMedal("What A Shifty Character!").unlocked)
							{
								API.unlockMedal("What A Shifty Character!");
							}
							
							score += 100;
							shifty.retreat();
						}
					}
				}
				
				//Update animated tiles
				updateAnimatedTiles();
				
				// Update the score
				scoreText.text = score.toString();
				
				// Update the timer
				time += FlxG.elapsed;
				timeText.text = FlxU.formatTime(time);
				
				//Testing an overlap collision method.
				var topType:int = topMap.getTile(Math.floor((topPlayer.x + topPlayer.width / 2) / 32), Math.floor(topPlayer.y / 32));
				var topScore:int = scoreMap.getTile(Math.floor((topPlayer.x + topPlayer.width / 2) / 32), Math.floor(topPlayer.y / 32));
				var bottomType:int = topMap.getTile(Math.floor((bottomPlayer.x + bottomPlayer.width / 2) / 32), Math.floor(bottomPlayer.y / 32));
				var bottomScore:int = scoreMap.getTile(Math.floor((bottomPlayer.x + bottomPlayer.width / 2) / 32), Math.floor(bottomPlayer.y / 32));
				if (topPlayer.getMoveLane())
				{
					if (topPlayer.getDirection() == 0)
					{
						if (topPlayer. y < topPlayer.getTargetLane())
						{
							topType = topMap.getTile(Math.floor((topPlayer.x + topPlayer.width / 2) / 32), Math.floor(topPlayer.getTargetLane() / 32))
						}
					}
					else
					{
						if (topPlayer. y > topPlayer.getTargetLane())
						{
							topType = topMap.getTile(Math.floor((topPlayer.x + topPlayer.width / 2) / 32), Math.floor(topPlayer.getTargetLane() / 32))
						}
					}
				}
				if (bottomPlayer.getMoveLane())
				{
					bottomType = 1;
				}
				switch(topType)
				{
					case 2:
						pitTileCollision(0, Math.floor((topPlayer.x + topPlayer.width / 2) / 32));
						break;
					case 3:
						downTileCollision(0);
						break;
					case 4:
						upTileCollision(0);
						break;
					case 5:
						speedTileCollision(0);
						break;
					case 7:
						monsterTileCollision(0);
						break;
				}
				switch(bottomType)
				{
					case 2:
						pitTileCollision(1, Math.floor((bottomPlayer.x + bottomPlayer.width / 2) / 32));
						break;
					case 3:
						downTileCollision(1);
						break;
					case 4:
						upTileCollision(1);
						break;
					case 5:
						speedTileCollision(1);
						break;
					case 6:
						monsterTileCollision(1);
						break;
				}
				
				if (topScore == 1)
				{
					scoreTileCollision();
					scoreMap.setTile(Math.floor((topPlayer.x + topPlayer.width / 2) / 32), Math.floor(topPlayer.y / 32), 0, true);
				}
				else if (topScore == 2)
				{
					tileChestCollision();
					scoreMap.setTile(Math.floor((topPlayer.x + topPlayer.width / 2) / 32), Math.floor(topPlayer.y / 32), 0, true);
				}
				if (bottomScore == 1)
				{
					scoreTileCollision();
					scoreMap.setTile(Math.floor((bottomPlayer.x + bottomPlayer.width / 2) / 32), Math.floor(bottomPlayer.y / 32), 0, true);
				}
				else if (bottomScore == 2)
				{
					tileChestCollision();
					scoreMap.setTile(Math.floor((bottomPlayer.x + bottomPlayer.width / 2) / 32), Math.floor(bottomPlayer.y / 32), 0, true);
				}
				
				if (swapOnCooldown)
				{
					timeOnCooldown = time - timeStartedCooldown;
					if (timeOnCooldown >= 2)
					{
						swapButton.alpha = 1;
						swapOnCooldown = false;
					}
				}
			}
			else
			{
				if (!topPlayer.alive && !bottomPlayer.alive)
				{
					if (!API.getMedal("TPK").unlocked)
					{
						API.unlockMedal("TPK");
					}
				}
				if (!API.getMedal("Fallen Hero").unlocked)
				{
					API.unlockMedal("Fallen Hero");
				}
				MenuState.setDied(true);
				FlxG.switchState(new LoseState(level));
			}
		}
		
		//} endregion
		
		//{ region Collision Methods
		
		// if a player collides with an upTile, call this function
		// player type can either be a 0 or 1, 0 is for top player, 1 is for bottom player, the function needs to know which player to move up a tile
		public function upTileCollision(playerType:int): void
		{
			if (playerType == 0)
			{
				if (topPlayer.getLane() > 1 && !topPlayer.getMoveLane())
				{
					topPlayer.switchLane(0);
				}
			}
			
			if (playerType == 1)
			{
				if (bottomPlayer.getLane() > 1  && !bottomPlayer.getMoveLane())
				{
					bottomPlayer.switchLane(0);
				}
			}
		}
		
		// if a player collides with an downTile, call this function
		// player type can either be a 0 or 1, 0 is for top player, 1 is for bottom player, the function needs to know which player to move down a tile
		public function downTileCollision(playerType:int): void
		{
			if (playerType == 0)
			{
				if (topPlayer.getLane() < 5 && !topPlayer.getMoveLane())
				{
					topPlayer.switchLane(1); 
				}
			}
			
			if (playerType == 1)
			{
				if (bottomPlayer.getLane() < 5 && !bottomPlayer.getMoveLane())
				{
					bottomPlayer.switchLane(1); 
				}
			}
		}
		
		// if a player collides with an scoreTile, call this function
		public function scoreTileCollision(): void
		{
			score += 10;
			FlxG.play(Sources.Mp3Points, 0.2);
		}
		
		public function pitTileCollision(playerType:int, deathTileX:int):void 
		{
			if (playerType == 0)
			{
				topPlayer.fall(deathTileX * 32);
				topScroll.setSpeed(0);
			}
			else
			{
				bottomPlayer.fall(deathTileX * 32);
				bottomScroll.setSpeed(0);
			}
		}
		
		public function monsterTileCollision(playerType:int):void
		{
			if (playerType == 0)
			{
				if (!topPlayer.getDying())
				{
					FlxG.play(Sources.Mp3Hurt, 0.2);
					topPlayer.killed();
					topScroll.setSpeed(0);
				}
			}
			else
			{
				if (!bottomPlayer.getDying())
				{
					bottomPlayer.killed();
					bottomScroll.setSpeed(0);
					FlxG.play(Sources.Mp3Hurt, 0.5);
				}
			}
		}
		
		public function tileChestCollision() : void
		{
			FlxG.play(Sources.Mp3Tile, 0.3);
			if (numTiles < 12)
			{
				var category:int = Math.floor(Math.random() * 99) + 1;
				var tI:int;
				var bI:int;
				
				if (category <= 30)
				{
					tI = 1;
				}
				else if (category <= 55)
				{
					tI = 3;
				}
				else if (category <= 80)
				{
					tI = 4;
				}
				else
				{
					tI = 5;
				}
				
				category = Math.floor(Math.random() * 99) + 1;
				
				if (category <= 30)
				{
					bI = 1;
				}
				else if (category <= 55)
				{
					bI = 3;
				}
				else if (category <= 80)
				{
					bI = 4;
				}
				else
				{
					bI = 5;
				}
				
				var rTile:PickableTile = new PickableTile(tI, bI);
				addTileToInventory(rTile);
			}
		}
		
		public function speedTileCollision(playerType:int):void
		{
			if (playerType == 0)
			{
				if (topPlayer.getSpeed() + 12 <= 96)
				{
					topPlayer.setSpeed(topPlayer.getSpeed() + 12);
					topScroll.setSpeed(topScroll.getSpeed() + 12);
					bottomPlayer.setSpeed(bottomPlayer.getSpeed() + 12);
					bottomScroll.setSpeed(bottomScroll.getSpeed() + 12);
				}
				
				topMap.setTile(Math.floor((topPlayer.x + topPlayer.width / 2) / 32), Math.floor(topPlayer.y / 32), 1, false);
			}
			if (playerType == 1)
			{
				var newSpeed:int = bottomPlayer.getSpeed() - 12;
				if (newSpeed < 24)
				{
					newSpeed = 24;
				}
				topPlayer.setSpeed(newSpeed);
				topScroll.setSpeed(newSpeed);
				bottomPlayer.setSpeed(newSpeed);
				bottomScroll.setSpeed(newSpeed);
				
				topMap.setTile(Math.floor((bottomPlayer.x + bottomPlayer.width / 2) / 32), Math.floor(bottomPlayer.y / 32), 1, false);
			}
		}
		
		//} endregion
		
		//{ region Array Methods
		
		public function removeTileFromInventory(index:int):void
		{
			hud.remove(inventory[index].getTopTile());
			hud.remove(inventory[index].getBottomTile());
			if (index < inventory.length - 1)
			{
				var temp:PickableTile;
				for (var i:int = index + 1; i < inventory.length; i++)
				{
					hud.remove(inventory[i].getTopTile());
					hud.remove(inventory[i].getBottomTile());
					temp = inventory[index];
					var x:int = inventory[i].getBounds().x;
					var y:int = inventory[i].getBounds().y;
					inventory[i].setBounds(temp.getBounds().x, temp.getBounds().y);
					temp.setBounds(x, y);
					inventory[index] = new PickableTile(inventory[i].getTopTile().getIndex(), inventory[i].getBottomTile().getIndex());
					inventory[index].setBounds(inventory[i].getBounds().x, inventory[i].getBounds().y);
					inventory[i] = temp;
					hud.add(inventory[index].getTopTile());
					hud.add(inventory[index].getBottomTile());
					index++;
				}
			}
			inventory.pop();
			numTiles--;
		}
		
		public function addTileToInventory(tile:PickableTile):void
		{
			tile.setBounds(20 + (42 * inventory.length), 240);
			inventory.push(tile);
			hud.add(tile.getTopTile());
			hud.add(tile.getBottomTile());
			numTiles++;
		}
		
		public function updateAnimatedTiles():void
		{
			for (var i:int = 0; i < animatedTiles.length; i++)
			{
				if (topMap.getTile(Math.floor(animatedTiles[i].x / 32), Math.floor(animatedTiles[i].y / 32)) != animatedTiles[i].getIndex())
				{
					removeAnimatedTile(i);
					i--;
				}
			}
		}
		
		public function removeAnimatedTile(index:int):void
		{
			tiles.remove(animatedTiles[index]);
			if (index < animatedTiles.length - 1)
			{
				var temp:AnimatedTiles;
				for (var i:int = index + 1; i < animatedTiles.length; i++)
				{
					tiles.remove(animatedTiles[i]);
					temp = animatedTiles[index];
					animatedTiles[index] = new AnimatedTiles(animatedTiles[i].getIndex(), animatedTiles[i].x, animatedTiles[i].y);
					animatedTiles[i] = temp;
					tiles.add(animatedTiles[index]);
					index++;
				}
			}
			animatedTiles.pop();
		}
		
		//} endregion
	}
}