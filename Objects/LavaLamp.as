package Objects
{
	public class LavaLamp extends ObjectBase
	{
		public function LavaLamp(x:int, y:int, w:int, h:int)
		{
			super();
			this.x = x;
			this.y = y;
			this.width = w;
			this.height = h;
			this.interactable = true;
			this.collidable = true;
			this.displayName = "Lava Lamp";
			this.description = "It doesn't give much light.";
		}
	}
}