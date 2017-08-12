package Objects
{
	
	import flash.events.MouseEvent;
	
	public class Chest extends UsableObject
	{
		public function Chest(x:int, y:int, w:int, h:int)
		{
			super();
			this.y = y;
			this.x = x;
			this.width = w;
			this.height = h;
			this.interactable = true;
			this.collidable = true;
			this.useText = "Open";
		}
	}
}