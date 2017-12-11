package Objects 
{
	import Items.Food;
	/**
	 * ...
	 * @author Rixium
	 */
	public class Fridge extends Chest 
	{
		
		public function Fridge(x:int, y:int, w:int, h:int) 
		{
			super();
			this.x = x;
			this.y = y;
			this.width = w;
			this.height = h;
			this.interactable = true;
			this.collidable = true;
			this.useText = "Search";
			this.item = new Food();
		}
		
	}

}