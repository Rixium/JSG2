package Objects
{
	public class StudioLight extends ObjectBase
	{
		public function StudioLight(x:int, y:int, w:int, h:int)
		{
			super();
			this.y = y;
			this.x = x;
			this.width = w;
			this.height = h;
			this.interactable = true;
			this.collidable = true;
		}
	}
}