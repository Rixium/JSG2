package Helpers 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	import Constants.Keys;
	import Constants.GameManager;
	import Sounds.YeahSound;
	
	/**
	 * ...
	 * @author ...
	 */
	
	public class TutorialText extends MovieClip
	{
		
		var key:int;
		var control:String;
		var mustDo:Boolean;
		var tutorialManager:TutorialManager;
		var timer:Timer;
		var action:String;
		
		public function TutorialText(tutorialManager:TutorialManager, control:String, key:int, action:String, mustDo:Boolean) 
		{
			this.tutorialManager = tutorialManager;
			this.key = key;
			this.control = control;
			this.mustDo = mustDo;
			x = GameManager.sean.x + GameManager.sean.width / 2;
			y = GameManager.sean.y - GameManager.sean.height;
			if (key == 0) {
				this.action = action;
			}
		}
		
		public function Initialize() {
			if(key != 0) {
				this.inner.tutText.text = control + "[" + Keys.GetDictionary()[key] + "]";
			} else {
				this.inner.tutText.text = control + "[" + action + "]";
			}
			
			if (mustDo) {
				if(key != 0) {
					GameManager.main.stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
				} else {
					GameManager.main.stage.addEventListener(MouseEvent.CLICK, MouseDown);
				}
			} else {
				timer = new Timer(2000, 1);
				timer.addEventListener(TimerEvent.TIMER, EndTimer);
				timer.start();
			}
		}
		
		private function EndTimer(e:TimerEvent) {
			timer.removeEventListener(TimerEvent.TIMER, EndTimer);
			gotoAndPlay("End");
			addEventListener("Destroy", Destroy);
		}
		
		private function MouseDown(e:MouseEvent) {
			var trans:SoundTransform = new SoundTransform(GameManager.soundLevel * 2, 0);
			var channel:SoundChannel = new Sounds.YeahSound().play(0, 0, trans);
			trans = null;
			channel = null;
			gotoAndPlay("End");
			GameManager.main.stage.removeEventListener(MouseEvent.CLICK, MouseDown);
			addEventListener("Destroy", Destroy);
		}
		
		private function KeyDown(e:KeyboardEvent) {
			if (e.keyCode == key) {
				var trans:SoundTransform = new SoundTransform(GameManager.soundLevel * 2, 0);
				var channel:SoundChannel = new Sounds.YeahSound().play(0, 0, trans);
				trans = null;
				channel = null;
				gotoAndPlay("End");
				GameManager.main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
				addEventListener("Destroy", Destroy);
			}
		}
		
		private function Destroy(e:Event) {
			removeEventListener("Destroy", Destroy);
			if(tutorialManager != null) {
				tutorialManager.next();
			} else {
				parent.removeChild(this);
			}
		}
	}

}