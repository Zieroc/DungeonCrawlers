package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxButtonPlus;
	
	public class LevelState extends FlxState
	{
		private var player:Player;
		private var background:FlxSprite, normal:FlxSprite, hover:FlxSprite, arrow:FlxSprite;
		private var level:int;
		private var score:int, finalScore:int, timeMul:int, time:int;
		private static var totalScore:int = 0;
		
		private var scoreText:FlxText, finalScoreText:FlxText, totalScoreText:FlxText;
		private var timeText:FlxText;
		
		private var button:FlxButtonPlus;

		public function LevelState(level:int, score:int, time:int, timeMul:int)
		{
			super();
			this.level = level;
			this.score = score;
			this.time = time;
			this.timeMul = timeMul;
			finalScore = score * timeMul;
			
			setTotalScore(getTotalScore() + (score * timeMul));
		} 
		
		override public function create():void
		{
			background = new FlxSprite(0, 0, Sources.ImgLevelBackground);
			normal = new FlxSprite(0, 0, Sources.ImgNextLevelButton);
			hover = new FlxSprite(0, 0, Sources.ImgNextLevelButtonHover);
			arrow = new FlxSprite(450, 311, Sources.ImgLevelArrow);
			add(background);
			
			button = new FlxButtonPlus(274, 350, addPlayer);
			button.loadGraphic(normal, hover);
			add(button);
			
			scoreText = new FlxText(224, 226, 100, score.toString());
			scoreText.setFormat(null, 24, 0x000000, null, 0x000000);
			add(scoreText);
			
			timeText = new FlxText(52, 226, 100, FlxU.formatTime(time));
			timeText.setFormat(null, 24, 0x000000, null, 0x000000);
			add(timeText);
			
			finalScoreText = new FlxText(449, 226, 100, finalScore.toString());
			finalScoreText.setFormat(null, 24, 0x000000, null, 0x000000);
			add(finalScoreText);
			
			totalScoreText = new FlxText(67, 418, 100, totalScore.toString());
			totalScoreText.setFormat(null, 24, 0x000000, null, 0x000000);
			add(totalScoreText);
			
			FlxG.mouse.show();
			
			player = new Player(true);
			player.x = 200;
			player.y = 311;
			player.setSpeed(100);
			player.play("standard");
			
		} // end function create
 
 
		override public function update():void
		{
			super.update(); // calls update on everything you added to the game loop
 
			if (player.x > 450)
			{
				if (level <= 10)
				{
					FlxG.switchState(new PlayState(level));
				}
				else
				{
					FlxG.switchState(new WinState());
				}
			}
			
		} // end function update
		
		private function addPlayer():void
		{
			add(arrow);
			add(player);
		}
		
		public static function setTotalScore(value:int):void
		{
			totalScore = value;
		}
		
		public static function getTotalScore():int
		{
			return totalScore;
		}
	}
}