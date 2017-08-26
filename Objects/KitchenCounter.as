package Objects 
{
	/**
	 * ...
	 * @author Rixium
	 */
	public class KitchenCounter extends ObjectBase 
	{
		
		public function KitchenCounter(x:int, y:int, w:int, h:int) 
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