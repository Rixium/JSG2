package Objects
{
	public class KnifeBlock extends ObjectBase
	{
		public function KnifeBlock(x:int, y:int, w:int, h:int)
		{
			super();
			this.x = x;
			this.y = y;
			this.width = w;
			this.height = h;
			this.interactable = true;
			this.collidable = true;
			this.displayName = "Knife Block";
			this.description = "An assortment of knives.";
		}
	}
}