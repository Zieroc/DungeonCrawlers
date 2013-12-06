package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author ...
	 */
	public class HowToState extends FlxState
	{
		
		private var background:FlxSprite;
		private var nextButton:FlxButton;
		
		public function HowToState()
		{
			super();
		} 
		
		override public function create():void
		{
			background = new FlxSprite(0, 0, Sources.ImgHowTo1);
			add(background);
			
			nextButton = new FlxButton(FlxG.width / 2, 440, "Next", next)
			nextButton.x = FlxG.width / 2 - nextButton.width / 2;
			add(nextButton);
 
		}
 
 
		override public function update():void
		{
			super.update(); // calls update on everything you added to the game loop
 
		} // end function update
		
		private function next():void
		{
			FlxG.switchState(new HowTo2State());
		}
	}

}