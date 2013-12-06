package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author ...
	 */
	public class CreditState extends FlxState
	{
		
		private var background:FlxSprite;
		private var nextButton:FlxButton;
		
		public function CreditState()
		{
			super();
		} 
		
		override public function create():void
		{
			background = new FlxSprite(0, 0, Sources.ImgCredits);
			add(background);
			
			nextButton = new FlxButton(FlxG.width / 2, 440, "Menu", menu)
			nextButton.x = FlxG.width / 2 - nextButton.width / 2;
			add(nextButton);
 
		}
 
 
		override public function update():void
		{
			super.update(); // calls update on everything you added to the game loop
 
		} // end function update
		
		private function menu():void
		{
			FlxG.switchState(new MenuState());
		}
	}

}