package
{
	import org.flixel.*;
	
	public class Game extends FlxGame
	{
		private const resolution:FlxPoint = new FlxPoint(640, 480);
		private const zoom:uint = 1;
		private const fps:uint = 60;
		
		public function Game()
		{
			super(resolution.x / zoom, resolution.y / zoom, MenuState, zoom);
			FlxG.flashFramerate = fps;
		}
	}
}