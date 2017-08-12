package Objects
{
	public class Shelf extends ObjectBase
	{
		public function Shelf(x:int, y:int, w:int, h:int)
		{
			super();
			this.x = x;
			this.y = y;
			this.width = w;
			this.height = h;
			this.interactable = true;
			this.collidable = true;
		}
	}
}