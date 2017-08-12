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
		
		public function Book(x:int, y:int, w:int, h:int) 
		{
			super();
			
			this.x = x;
			this.y = y;
			this.width = w;
			this.height = h;
			this.interactable = true;
			this.collidable = false;
			this.useText = "Read";
			
		}
		
		
		
	}

}