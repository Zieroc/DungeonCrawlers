package  
{
	import org.flixel.*;
	import com.newgrounds.*;
	
	public class WinState extends FlxState
	{
		private var background:FlxSprite;
		private var menuButton:FlxButton;
		
		public function WinState()
		{
			super();
			
		}  // end function WinState
		
		override public function create():void
		{
			background = new FlxSprite(0, 0, Sources.ImgWinBackground);
			add(background);
			
			menuButton = new FlxButton(FlxG.width / 2, 270, "Back To Menu", menu)
			menuButton.x = FlxG.width / 2 - menuButton.width / 2;
			add(menuButton);
			
			var totalScoreText:FlxText = new FlxText(289, 407, 100, LevelState.getTotalScore().toString());
			totalScoreText.setFormat(null, 24, 0x000000, null, 0x000000);
			add(totalScoreText);
			
			FlxG.mouse.show();
			
			if (!MenuState.getDied())
			{
				if (!API.getMedal("Kevin won't get this").unlocked)
				{
					API.unlockMedal("Kevin won't get this");
				}
			}
			
			API.postScore("High Scores", LevelState.getTotalScore());
 
		} // end function create
 
 
		override public function update():void
		{
			super.update(); // calls update on everything you added to the game loop
 
		} // end function update
		
		private function menu():void
		{
			FlxG.switchState(new MenuState);
		}
	}
}