package Objects
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	import Constants.GameManager;
	
	public class ObjectBase extends MovieClip
	{
		
		public var eBounds:MovieClip;
		
		public var displayName:String;
		public var description:String;
		public var interactable:Boolean;
		public var collidable:Boolean;
		public var usable:Boolean;
		
		public function ObjectBase()
		{	
			eBounds = getChildByName("bounds") as MovieClip;
			addEventListener(MouseEvent.MOUSE_OVER, MouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
			addEventListener(MouseEvent.CLICK, MouseClick);
			addEventListener(Event.REMOVED_FROM_STAGE, OnRemove);
		}
		
		public function OnRemove(e:Event):void {
			removeEventListener(MouseEvent.MOUSE_OVER, MouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, MouseOut);
			removeEventListener(MouseEvent.CLICK, MouseClick);
			removeEventListener(Event.REMOVED_FROM_STAGE, OnRemove);
		}
		
		public function MouseClick(e:MouseEvent):void {
			GameManager.ui.SetDescriptor(description, false);
		}
		
		public function MouseOver(e:MouseEvent):void {
			GameManager.mouseInfo.SetText(displayName);
		}
		
		public function MouseOut(e:MouseEvent):void {
			GameManager.mouseInfo.SetText("");
		}
		
	}
}