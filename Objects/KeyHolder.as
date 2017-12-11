package Objects 
{
	/**
	 * ...
	 * @author Rixium
	 */
	public class KeyHolder extends Chest 
	{
		
		public function KeyHolder(x:int, y:int, w:int, h:int) 
		{
			super();
			this.x = x;
			this.y = y;
			this.width = w;
			this.height = h;
			this.interactable = true;
			this.collidable = true;
			gotoAndStop(1);
			useText = "Take";
		}
		
		protected override function Use():void {
			super.Use();
			if (item == null) {
				description = "It's empty.";
				gotoAndStop(2);
			}
		}
		
	}

}