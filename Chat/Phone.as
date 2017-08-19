package Chat 
{
	
	import Constants.GameManager;
	import Sounds.AnswerPhone;
	import Sounds.PhoneVibrateSound;
	import Sounds.RingtoneSound;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.media.SoundChannel;
	import Constants.Keys;
	import flash.media.SoundTransform;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class Phone extends Chatter 
	{
		
		public var ringing:Boolean;
		var trans:SoundTransform;
		var channel:SoundChannel;
		public var inCall:Boolean;
		
		public function Phone() 
		{
			super();
			trans = new SoundTransform(GameManager.soundLevel, 0); 
			
			this.x = GameManager.main.stage.stageWidth - this.width - 20;
			this.y = GameManager.main.stage.stageHeight - this.height - 10;
		}
		
		public function Check() {
			if (conversation != null && !ringing) {
				GameManager.ui.SetDescriptor("Answer Phone [" + Keys.KeyToChar[Keys.USE] + "]", true);
				addEventListener(MouseEvent.CLICK, StartPhone);
				GameManager.main.stage.addEventListener(KeyboardEvent.KEY_DOWN, StartPhoneByKeyboard);
				ringing = true;
				GameManager.main.addChild(this);
				var ringSound:RingtoneSound = new RingtoneSound();;
				channel = ringSound.play(0, 9999, trans);
				ringSound = null;
			} else {
				if (conversation == null && ringing) {
					inCall = false;
					ringing = false;
				}
			}
		}
		
		public function StartPhoneByKeyboard(e:KeyboardEvent) {
			if (e.keyCode == Keys.USE) {
				inCall = true;
				GameManager.main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, StartPhoneByKeyboard);
				removeEventListener(MouseEvent.CLICK, StartPhone);
				GameManager.ui.SetDescriptor("", true);
				if (!chatting) {
					channel.stop();
					channel = null;
					var answerPhone:AnswerPhone = new AnswerPhone();
					answerPhone.play();
					answerPhone = null;
					chatting = true;
					StartChat();
					GameManager.main.removeChild(this);
				}
			}
		}
		
		public function StartPhone(e:MouseEvent) {
			if (!chatting) {
				inCall = true;
				GameManager.main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, StartPhoneByKeyboard);
				GameManager.ui.SetDescriptor("", true);
				removeEventListener(MouseEvent.CLICK, StartPhone);
				channel.stop();
				channel = null;
				var answerPhone:AnswerPhone = new AnswerPhone();
				answerPhone.play();
				answerPhone = null;
				chatting = true;
				StartChat();
				GameManager.main.removeChild(this);
			}
		}
		

	}

}