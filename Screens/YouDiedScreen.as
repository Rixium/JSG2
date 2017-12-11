package Screens 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import Constants.GameManager;
	
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import Sounds.SadPiano;
	import Constants.Keys;

	/**
	 * ...
	 * @author ...
	 */
	public class YouDiedScreen extends MovieClip
	{
		
		var timer:Timer = new Timer(5000, 1);
		var timing:Boolean = false;
		var fadeOut:Boolean = false;
		
		public function YouDiedScreen() 
		{
			addEventListener(Event.ENTER_FRAME, Update);
			alpha = 0;
			x = GameManager.main.stage.stageWidth / 2;
			y = GameManager.main.stage.stageHeight / 2;
			diedText.text = "SKIP [" + Keys.GetDictionary()[Keys.ROLL] + "]";
			GameManager.gameScreen.musicManager.FadeOut();
			var trans:SoundTransform = new SoundTransform(GameManager.soundLevel, 0);
			var channel:SoundChannel = new SadPiano().play(0, 0, trans);
			channel = null;
			trans = null;
		}
		
		private function adStarted() {
			GameManager.gameScreen.musicManager.Mute();
		}
		
		private function adEnded() {	
			GameManager.gameScreen.musicManager.UnMute();
			dispatchEvent(new Event("Finished"));
		}
		
		public function End() {
			if(parent != null){
				parent.removeChild(this);
				removeEventListener(Event.ENTER_FRAME, Update);
				fadeOut = false;
			}
		}
		
		public function ForceFade():void {
			fadeOut = true;
		}
		
		public function Update(e:Event) {
			if(!timing) {
				if (alpha < 1) {
					alpha += 0.05;
				} else {
					if(!timing) {
						timer.addEventListener(TimerEvent.TIMER, Finish);
						timer.start();
						timing = true;
					}
				} 
			}
			if (fadeOut) {
				if (alpha > 0) {
					alpha -= 0.05;
				} else {
					removeEventListener(Event.ENTER_FRAME, Update);
					RequestAd();
				}
			}
		}
		
		public function RequestAd():void {
			try {
				
			} catch(error:Error) {
				trace("Error, cannot trigger ad, reason:" + error.message);
			}
		}
		
		private function Finish(e:TimerEvent) {
			fadeOut = true;
		}
		
	}

}