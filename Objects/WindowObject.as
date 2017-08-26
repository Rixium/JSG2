package Objects 
{
	/**
	 * ...
	 * @author Rixium
	 */
	public class WindowObject extends ObjectBase 
	{
		
		private var windowType:String;
		public function WindowObject(x:int, y:int, w:int, h:int, windowType:String) 
		{
			super();
			this.x = x;
			this.y = y;
			this.width = w;
			this.height = h;
			this.interactable = true;
			this.collidable = false;
			this.windowType = windowType;
			gotoAndStop(windowType);
		}
		
	}

}