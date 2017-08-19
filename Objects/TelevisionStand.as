package Objects 
{
	/**
	 * ...
	 * @author Rixium
	 */
	public class TelevisionStand extends ObjectBase 
	{
		
		public function TelevisionStand(x:int, y:int, w:int, h:int) 
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