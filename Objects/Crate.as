package Objects 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Rixium
	 */
	public class Crate extends Chest 
	{
		
		public function Crate(x:int, y:int, w:int, h:int) 
		{
			super();
			this.x = x;
			this.y = y;
			this.width = w;
			this.height = h;
			this.interactable = true;
			this.collidable = true;
			useText = "Search";
		}

	}

}