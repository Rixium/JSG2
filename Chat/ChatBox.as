package Chat 
{
	
	import Sounds.CharSound;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.text.TextField;
	import Constants.Keys;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import Constants.GameManager;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class ChatBox extends MovieClip
	{
		
		var line:String;
		var startLine:String;
		var currentShowing:String;
		var channel:SoundChannel;
		var voiceChannel:SoundChannel;
		var trans:SoundTransform;
		public var finished:Boolean = false;
		var audio:Sound;
		var characterTimer:int = 0;
		var charSpeed:int = 0;
		
		public function ChatBox() 
		{
			trans = new SoundTransform(GameManager.soundLevel, 0); 
			
			var skipKey:TextField = getChildByName("skipKey") as TextField;
			skipKey.text = "Skip [" + Keys.KeyToChar[Keys.ROLL] + "]";
			skipKey = null;
			addEventListener(Event.ENTER_FRAME, Update);
		}
		
		public function Kill() {
			removeEventListener(Event.ENTER_FRAME, Update);
		}
		
		private function Update(e:Event) {
			if (line.length > 0 && characterTimer <= 0) {
				if(channel != null) {
					channel.stop();
				}
				var charSound:CharSound = new CharSound();
				trans = new SoundTransform(GameManager.soundLevel, 0);
				channel = charSound.play(0, 0, trans);
				charSound = null;
				currentShowing += line.charAt(0);
				line = line.substr(1);
				characterTimer = charSpeed;
				var chatText:TextField = getChildByName("chatText") as TextField;
				chatText.text = currentShowing;
				chatText = null;
			} else {
				finished = true;
			}
			
			if (characterTimer > 0) {
				characterTimer--;
			}
		}
		
		public function SetChatLine(line:ChatLine) {
			this.startLine = line.chatLine;
			finished = false;
			currentShowing = "";
			charSpeed = line.characterTime;
			chatHead.gotoAndStop(line.talker);
			this.line = line.chatLine;
			if (audio != null) {
				voiceChannel.stop();
			}
			if (line.audio != null) {
				this.audio = line.audio;
				trans = new SoundTransform(GameManager.soundLevel, 0);
				voiceChannel = audio.play(0, 0, trans);
			}
		}
		
		public function SetEndLine(string:String) {
			var skipKey:TextField = getChildByName("skipKey") as TextField;
			skipKey.text = string + " [" + Keys.KeyToChar[Keys.ROLL] + "]";
			skipKey = null;
		}
		
		public function Finish() {
			currentShowing = startLine;
			line = "";
			finished = true;
			var chatText:TextField = getChildByName("chatText") as TextField;
			chatText.text = currentShowing;
			chatText = null;
			channel.stop();
			if(audio != null) {
				voiceChannel.stop();
			}
		}

	}

}