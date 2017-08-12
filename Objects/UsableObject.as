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
		protected var useText:String;
		private var textShow:TextDisplay;
		private var showing:Boolean;
		
		public function UsableObject() 
		{
			super();
			this.usable = true;
			GameManager.main.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			this.useBounds = getChildByName("useBounds") as MovieClip;
			addEventListener(Event.ENTER_FRAME, Update);
		}
		
		public function Update(e:Event):void {
			if(!showing) {
				if (GameManager.sean.eBounds.hitTestObject(useBounds)) {
					//textShow = new TextDisplay(useText, x + width / 2, y - 50);
					showing = true;
					var character:String = String.fromCharCode(Keys.USE);
					GameManager.ui.SetDescriptor("'" + character + "' - " + useText, true);
				}
			} else {
				if (!GameManager.sean.eBounds.hitTestObject(useBounds)) {
					//textShow.Destroy();
					showing = false;
					GameManager.ui.SetDescriptor("", true);
				}
			}
			
			
		}
		
		public function KeyDown(e:KeyboardEvent):void {
			if (e.keyCode == Keys.USE) {
				if (GameManager.sean.eBounds.hitTestObject(useBounds)) {
					
				}
			}
		}
		
	}

}