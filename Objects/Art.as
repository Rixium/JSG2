package Objects 
{
	/**
	 * ...
	 * @author Rixium
	 */
	public class Art extends ObjectBase 
	{
		
		public function Art(x:int, y:int, w:int, h:int, art:int) 
		{
			super();
			this.gotoAndStop(art);
			this.x = x;
			this.y = y;
			this.width = w;
			this.height = h;
			this.interactable = true;
			this.collidable = true;
		}
		
	}

}