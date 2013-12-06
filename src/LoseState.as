package  
{
	import org.flixel.*;
	import com.newgrounds.*;
	
	public class LoseState extends FlxState
	{
		private var background:FlxSprite;
		private var retryButton:FlxButton;
		private var menuButton:FlxButton;
		
		private var level:int;
		
		public function LoseState(level:int)
		{
			super();
			this.level = level;
			
		}  // end function LoseState
		
		override public function create():void
		{
			background = new FlxSprite(0, 0, Sources.ImgLoseBackground);
			add(background);
			
			retryButton = new FlxButton(FlxG.width / 2, 170, "Retry", retry)
			retryButton.x = FlxG.width / 2 - retryButton.width / 2;
			add(retryButton);
			
			menuButton = new FlxButton(FlxG.width / 2, 250, "Quit", quit)
			menuButton.x = FlxG.width / 2 - menuButton.width / 2;
			add(menuButton);
			
			var totalScoreText:FlxText = new FlxText(289, 354, 100, LevelState.getTotalScore().toString());
			totalScoreText.setFormat(null, 24, 0x000000, null, 0x000000);
			add(totalScoreText);
			
			FlxG.mouse.show();
 
		} // end function create
 
 
		override public function update():void
		{
			super.update(); // calls update on everything you added to the game loop
 
		} // end function update
		
		private function retry():void
		{
			FlxG.switchState(new PlayState(level));
		}
		
		private function quit():void
		{
			API.postScore("High Scores", LevelState.getTotalScore());
			FlxG.switchState(new MenuState);
		}
	}
}