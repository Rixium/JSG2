package Objects 
{
	/**
	 * ...
	 * @author Rixium
	 */
	public class KitchenCounterSink extends ObjectBase 
	{
		
		public function KitchenCounterSink(x:int, y:int, w:int, h:int) 
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