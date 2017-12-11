package Objects 
{
	/**
	 * ...
	 * @author Rixium
	 */
	public class MaCabinet extends Chest 
	{
		
		public function MaCabinet(x:int, y:int, w:int, h:int) 
		{
			super();
			this.x = x;
			this.y = y;
			this.width = w;
			this.height = h;
			this.interactable = true;
			this.collidable = true;
			
			displayName = "Drawers";
			description = "I don't want to know what's in there.";
		}
		
	}

}