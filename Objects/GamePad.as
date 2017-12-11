package Objects
{
	public class GamePad extends ObjectBase
	{
		public function GamePad(x:int, y:int, w:int, h:int)
		{
			super();
			this.x = x;
			this.y = y;
			this.width = w;
			this.height = h;
			this.interactable = true;
			this.collidable = true;
			this.displayName = "Gamepad";
			this.description = "Sweet gaming goodness.";
		}
	}
}