package  
{
	import org.flixel.*;
	import com.newgrounds.*;
	/**
	 * ...
	 * @author ...
	 */
	public class HowTo3State extends FlxState
	{
		
		private var background:FlxSprite;
		private var menuButton:FlxButton;
		
		public function HowTo3State()
		{
			super();

		}
		
		override public function create():void
		{
			background = new FlxSprite(0, 0, Sources.ImgHowTo3);
			add(background);
			
			menuButton = new FlxButton(FlxG.width / 2, 440, "Menu", menu)
			menuButton.x = FlxG.width / 2 - menuButton.width / 2;
			add(menuButton);
 
		} // end function create
 
 
		override public function update():void
		{
			super.update(); // calls update on everything you added to the game loop
 
		} // end function update
		
		private function menu():void
		{
			if (!API.getMedal("Read The Manual").unlocked)
			{
				API.unlockMedal("Read The Manual");
			}
			FlxG.switchState(new MenuState());
		}
		
	}

}