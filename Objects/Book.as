package Objects 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import Constants.GameManager;
	/**
	 * ...
	 * @author Rixium
	 */
	public class Book extends UsableObject 
	{
		
		private var info:BookInfo;
		private var isRead:Boolean = false;
		
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
			this.displayName = "Book";
			this.description = "Perhaps I should read that..";
			this.info = info;
		}
		
		override protected function Use():void 
		{
			info.OpenBook();
			if(!isRead) {
				isRead = true;
				GameManager.collectedBooks++;
				if (GameManager.collectedBooks >= 3) {
					
				}
			}
		}
		
	}

}