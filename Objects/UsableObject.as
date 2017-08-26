package Objects 
{
	/**
	 * ...
	 * @author Rixium
	 */
	import Constants.GameManager;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.display.MovieClip;
	import Constants.Keys;
	
	
	public class UsableObject extends ObjectBase 
	{
		
		private var useBounds:MovieClip;
		public var useText:String;
		private var textShow:TextDisplay;
		private var showing:Boolean;
		protected var canUse:Boolean = true;
		public var readyToUse:Boolean = true;
		
		public function UsableObject() 
		{
			super();
			this.usable = true;
			GameManager.main.stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			GameManager.main.stage.addEventListener(KeyboardEvent.KEY_UP, KeyUp);
			this.useBounds = getChildByName("useBounds") as MovieClip;
			addEventListener(Event.ENTER_FRAME, Update);
			addEventListener(Event.REMOVED_FROM_STAGE, RemoveListeners);
		}
		
		public function UseInitialize():void {
			GameManager.main.stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			this.useBounds = getChildByName("useBounds") as MovieClip;
			addEventListener(Event.ENTER_FRAME, Update);
			addEventListener(Event.REMOVED_FROM_STAGE, RemoveListeners);
		}
		
		public function Update(e:Event):void {
			if(readyToUse) {
				if(!GameManager.sean.phone.ringing) {
					if (GameManager.sean.eBounds.hitTestObject(useBounds) && !showing) {
						//textShow = new TextDisplay(useText, x + width / 2, y - 50);
						showing = true;
						var character:String = Keys.GetDictionary()[Keys.USE];
						GameManager.ui.SetDescriptor("'" + character + "' - " + useText, true);
					} else if (!GameManager.sean.eBounds.hitTestObject(useBounds) && showing) {
						//textShow.Destroy();
						showing = false;
						GameManager.ui.SetDescriptor("", true);
					}
				}
			}
		}
		
		public function RemoveListeners(e:Event):void {
			canUse = false;
			removeEventListener(Event.ENTER_FRAME, Update);
			GameManager.main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			removeEventListener(Event.REMOVED_FROM_STAGE, RemoveListeners);
		}
		
		
		public function KeyDown(e:KeyboardEvent):void {
			if (e.keyCode == Keys.USE && canUse && !GameManager.sean.phone.ringing) {
				canUse = false;
				if (GameManager.sean.eBounds.hitTestObject(useBounds)) {
					Use();
				}
			}
		}
		
		public function KeyUp(e:KeyboardEvent):void {
			if (e.keyCode == Keys.USE) {
				canUse = true;
			}
		}
		
		protected function Use():void {
			
		}
		
	}

}