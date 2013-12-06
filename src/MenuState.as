package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxButtonPlus;
	
	public class MenuState extends FlxState
	{
		private var background:FlxSprite, start:FlxSprite, startHover:FlxSprite, howTo:FlxSprite, howToHover:FlxSprite;
		private var startButton:FlxButtonPlus, howToButton:FlxButtonPlus;
		private var creditsButton:FlxButton;
		private static var died:Boolean;
		
		override public function create():void
		{
			background = new FlxSprite(0, 0, Sources.ImgMenuBackground);
			start = new FlxSprite(0, 0, Sources.ImgStartButton);
			startHover = new FlxSprite(0, 0, Sources.ImgStartButtonHover);
			howTo = new FlxSprite(0, 0, Sources.ImgHowToButton);
			howToHover = new FlxSprite(0, 0, Sources.ImgHowToButtonHover);
			add(background);
			
			startButton = new FlxButtonPlus(252, 243, switchStates);
			startButton.loadGraphic(start, startHover);
			add(startButton);
			
			howToButton = new FlxButtonPlus(277, 337, switchHowTo);
			howToButton.loadGraphic(howTo, howToHover);
			add(howToButton);
			
			creditsButton = new FlxButton(FlxG.width / 2, 440, "Credits", switchCredits)
			creditsButton.x = FlxG.width / 2 - creditsButton.width / 2;
			add(creditsButton);
			
			FlxG.playMusic(Sources.Mp3Menu, 1);
			
			FlxG.mouse.show();
 
		} // end function create
 
 
		override public function update():void
		{
			super.update(); // calls update on everything you added to the game loop
 
		} // end function update
		
		private function switchStates():void
		{
			ShiftyvanDam.levelToSpawn(Math.floor(Math.random() * 9) + 1);
			setDied(false);
			LevelState.setTotalScore(0);
			FlxG.switchState(new PlayState(1));
		}
		
		private function switchHowTo():void
		{
			FlxG.switchState(new HowToState());
		}
		
		private function switchCredits():void
		{
			FlxG.switchState(new CreditState());
		}
 
		public function MenuState()
		{
			super();
 
		}  // end function MenuState
		
		public static function setDied(value:Boolean):void
		{
			died = value;
		}
		
		public static function getDied():Boolean
		{
			return died;
		}
	}
}