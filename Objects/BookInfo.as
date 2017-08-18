package Objects 
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import Constants.GameManager;
	import flash.events.MouseEvent;
	import Sounds.OpenBookSound;
	import Sounds.CloseBookSound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class BookInfo extends MovieClip
	{
		
		var page1text:String;
		var page2text:String;
		
		public function BookInfo(page1text:String, page2text:String) 
		{
			this.page1text = page1text;
			this.page2text = page2text;
		}
		
		public function OpenBook():void {
			var openBookSound:OpenBookSound = new OpenBookSound();;
			var trans:SoundTransform = new SoundTransform(GameManager.soundLevel, 0); 
			var channel:SoundChannel = openBookSound.play(0, 1, trans);
			openBookSound = null;
			trans = null;
			channel = null;
			GameManager.main.addChild(this);
			GameManager.sean.reading = true;
			x = GameManager.main.stage.stageWidth / 2;
			y = GameManager.main.stage.stageHeight / 2;
			var page1:TextField = getChildByName("page1") as TextField;
			var page2:TextField = getChildByName("page2") as TextField;
			page1.text = page1text;
			page2.text = page2text;
			closeBookButton.addEventListener(MouseEvent.CLICK, CloseBook);
			page1 = null;
			page2 = null;
		}
		
		public function CloseBook(e:MouseEvent):void {
			var closeBookSound:CloseBookSound = new CloseBookSound();;
			var trans:SoundTransform = new SoundTransform(GameManager.soundLevel, 0); 
			var channel:SoundChannel = closeBookSound.play(0, 1, trans);
			closeBookSound = null;
			trans = null;
			channel = null;
			closeBookButton.removeEventListener(MouseEvent.CLICK, CloseBook);
			GameManager.main.removeChild(this);
			GameManager.main.stage.focus = GameManager.sean;
			GameManager.sean.reading = false;
		}
		
	}

}