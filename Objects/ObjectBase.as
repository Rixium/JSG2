package Objects
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	import Constants.GameManager;
	
	public class ObjectBase extends MovieClip
	{
		
		public var eBounds:MovieClip;
		private var useBounds:MovieClip;
		
		public var displayName:String;
		public var description:String;
		public var interactable:Boolean;
		public var collidable:Boolean;
		public var usable:Boolean;
		
		public function ObjectBase()
		{	
			eBounds = getChildByName("bounds") as MovieClip;
			useBounds = getChildByName("interactBounds") as MovieClip;
			useBounds.addEventListener(MouseEvent.MOUSE_OVER, MouseOver);
			useBounds.addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
			//useBounds.addEventListener(MouseEvent.CLICK, MouseClick);
			addEventListener(Event.REMOVED_FROM_STAGE, OnRemove);
		}
		
		public function Initialize() {
			eBounds = getChildByName("bounds") as MovieClip;
			useBounds = getChildByName("interactBounds") as MovieClip;
			useBounds.addEventListener(MouseEvent.MOUSE_OVER, MouseOver);
			useBounds.addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
			//useBounds.addEventListener(MouseEvent.CLICK, MouseClick);
			addEventListener(Event.REMOVED_FROM_STAGE, OnRemove);
		}
		
		public function OnRemove(e:Event):void {
			useBounds.removeEventListener(MouseEvent.MOUSE_OVER, MouseOver);
			useBounds.removeEventListener(MouseEvent.MOUSE_OUT, MouseOut);
			//useBounds.removeEventListener(MouseEvent.CLICK, MouseClick);
			removeEventListener(Event.REMOVED_FROM_STAGE, OnRemove);
		}
		
		public function MouseClick(e:MouseEvent):void {
			if(interactable) {
				GameManager.ui.SetDescriptor(description, false);
			}
		}
		
		public function MouseOver(e:MouseEvent):void {
			if(interactable && !GameManager.sean.phone.ringing){
				GameManager.mouseInfo.SetText(displayName);
				GameManager.ui.SetDescriptor(description, false);
			}
		}
		
		public function MouseOut(e:MouseEvent):void {
			if(interactable && !GameManager.sean.phone.ringing) {
				GameManager.mouseInfo.SetText("");
				GameManager.ui.SetDescriptor("", true);
			}
		}
		
	}
}