package Objects 
{
	/**
	 * ...
	 * @author Rixium
	 */
	public class DressingTable extends ObjectBase
	{
		
		public function DressingTable(x:int, y:int, w:int, h:int) 
		{
			super();
			this.x = x;
			this.y = y;
			this.width = w;
			this.height = h;
			this.interactable = true;
			this.collidable = true;
			this.displayName = "Dressing Table";
			this.description = "A place to put your face on.";
		}
		
	}

}