package Objects 
{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author Rixium
	 */
	public class Book extends UsableObject 
	{
		
		private var info:BookInfo;
		
		public function Book(x:int, y:int, w:int, h:int, info:BookInfo) 
		{
			super();
			
			this.x = x;
			this.y = y;
			this.width = w;
			this.height = h;
			this.interactable = true;
			this.collidable = false;
			this.useText = "Read";
			this.info = info;
		}
		
		override protected function Use():void 
		{
			info.OpenBook();
		}
		
	}

}