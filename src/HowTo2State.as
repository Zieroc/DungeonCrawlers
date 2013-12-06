package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author ...
	 */
	public class HowTo2State extends FlxState
	{
		
		private var background:FlxSprite;
		private var menuButton:FlxButton;
		
		public function HowTo2State()
		{
			super();

		}
		
		override public function create():void
		{
			background = new FlxSprite(0, 0, Sources.ImgHowTo2);
			add(background);
			
			menuButton = new FlxButton(FlxG.width / 2, 440, "Next", menu)
			menuButton.x = FlxG.width / 2 - menuButton.width / 2;
			add(menuButton);
 
		} // end function create
 
 
		override public function update():void
		{
			super.update(); // calls update on everything you added to the game loop
 
		} // end function update
		
		private function menu():void
		{
			
			FlxG.switchState(new HowTo3State());
		}
		
	}

}