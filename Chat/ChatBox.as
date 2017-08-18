package Chat 
{
	
	import Sounds.CharSound;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
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
		var trans:SoundTransform;
		public var finished:Boolean = false;
		
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
			if (line.length > 0) {
				if(channel != null) {
					channel.stop();
				}
				var charSound:CharSound = new CharSound();
				channel = charSound.play(0, 0, trans);
				charSound = null;
				currentShowing += line.charAt(0);
				line = line.substr(1);
				
				var chatText:TextField = getChildByName("chatText") as TextField;
				chatText.text = currentShowing;
				chatText = null;
			} else {
				finished = true;
			}
		}
		
		public function SetChatLine(line:ChatLine) {
			this.startLine = line.chatLine;
			finished = false;
			currentShowing = "";
			chatHead.gotoAndStop(line.talker);
			this.line = line.chatLine;
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
		}

	}

}