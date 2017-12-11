package Objects
{
	public class WorkBench extends ObjectBase
	{
		public function WorkBench(x:int, y:int, w:int, h:int)
		{
			super();
			this.x = x;
			this.y = y;
			this.width = w;
			this.height = h;
			this.interactable = true;
			this.collidable = true;
			this.displayName = "Workbench";
			this.description = "An expression of manliness.";
		}
	}
}