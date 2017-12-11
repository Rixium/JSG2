package Entity 
{
	/**
	 * ...
	 * @author Rixium
	 */
	public class Box extends DestroyableObject
	{
		
		public function Box() 
		{
			super();
			displayName = "Box";
			description = "A sturdy box.";
			stats = new Stats(1, 1, 1);
			canKnockback = false;
			this.x = x;
			this.y = y;
		}
		
	}

}