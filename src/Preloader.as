package  
{
    import com.newgrounds.*;
    import com.newgrounds.components.*;
    import flash.display.MovieClip;
	import flash.media.SoundTransform;

    public class Preloader extends MovieClip
    {
		//CHANGE THESE:
		private const id:String = "32836:Vew486q4";
		private const key:String = "wsIkYFbNUqoMuti5sdbXNTkCKENNO03Z"; //KEEP THIS SECRET!
		
        public function Preloader():void
        {
            var apiConnector:APIConnector = new APIConnector();
            apiConnector.className = "Main";
            apiConnector.apiId = id;
            apiConnector.encryptionKey = key;
            addChild(apiConnector);
			
            if(stage)
            {
                apiConnector.x = (stage.stageWidth - apiConnector.width) / 2;
                apiConnector.y = (stage.stageHeight - apiConnector.height) / 2;
            }
			var medalPopup:MedalPopup = new MedalPopup();
			medalPopup.soundTransform = new SoundTransform(0); //WILL MUTE THE MEDALPOPUP SOUND FROM NEWGROUNDS
			addChild(medalPopup);
			
			//information on API-integration: 
			//http://www.newgrounds.com/wiki/creator-resources/flash-api/getting-started-with-the-api/flixel
        }    
    }
}