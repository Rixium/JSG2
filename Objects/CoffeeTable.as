package Objects
{
	public class CoffeeTable extends ObjectBase
	{
		public function CoffeeTable(x:int, y:int, w:int, h:int)
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