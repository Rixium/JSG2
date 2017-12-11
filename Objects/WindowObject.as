package Objects 
{
	/**
	 * ...
	 * @author Rixium
	 */
	import Constants.WindowTypes;
	import Constants.GameManager;
	import Sounds.BasementSound;
	import Sounds.ScareSound;
	import flash.events.Event;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.Sound;
	
	public class WindowObject extends UsableObject 
	{
		
		private var windowType:String;
		
		public function WindowObject(x:int, y:int, w:int, h:int, windowType:String) 
		{
			gotoAndStop(windowType);
			super();
			this.x = x;
			this.y = y;
			this.width = w;
			this.height = h;
			this.interactable = true;
			this.collidable = false;
			this.windowType = windowType;
			this.useText = "Open";
		}
		
		protected override function Use():void {
			if(usable) {
				if (windowType == WindowTypes.MASROOM) {
					var trans:SoundTransform = new SoundTransform(GameManager.soundLevel, 0);
					var channel:SoundChannel = new ScareSound().play(0, 0, trans);
					trans = null;
					channel = null;
					dispatchEvent(new Event("used"));
					gotoAndStop("maRoomOpen");
					description = "A giant eye is destroying the city.";
					displayName = "Window";
					this.usable = false;
					GameManager.ui.SetDescriptor("", true);
				}
			}
		}
		
	}

}