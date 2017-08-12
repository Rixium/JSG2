package Entity
{
	
	import flash.display.MovieClip;
	import Constants.GameManager;
	import flash.events.MouseEvent;
	
	public class EntityBase extends MovieClip
	{
		
		protected var stats:Stats;
		protected var description:String;
		protected var displayName:String;
		
		public var eBounds:MovieClip;
		
		public function EntityBase()
		{
			eBounds = getChildByName("bounds") as MovieClip;
			
			var mouseOverBounds:MovieClip = getChildByName("mouseOverBounds") as MovieClip;
			
			mouseOverBounds.addEventListener(MouseEvent.MOUSE_OVER, MouseOver);
			mouseOverBounds.addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
			mouseOverBounds.addEventListener(MouseEvent.CLICK, MouseClick);
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