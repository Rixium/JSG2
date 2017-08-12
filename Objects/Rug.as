package Objects
{
	public class Rug extends ObjectBase
	{
		public function Rug(x:int, y:int, w:int, h:int)
		{
			super();
			
			this.x = x;
			this.y = y;
			this.width = w;
			this.height = h;
			this.interactable = true;
			this.collidable = false;
		}
	}
}