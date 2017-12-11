package Items 
{
	/**
	 * ...
	 * @author Rixium
	 */
	import Constants.ItemImages;
	import Constants.ItemTypes;
	import Sounds.EatSound;
	import Constants.GameManager;
	
	public class Food extends UsableItem
	{
		
		public function Food()
		{
			super(ItemImages.CHICKENLEG);
			displayName = "Food";
			description = "Healing +10 - Tasty, Deep fried goodness.";
			this.itemType = ItemTypes.USABLE;
			this.useSound = new EatSound();
		}
		
		override public function Use():Boolean
		{
			if(GameManager.sean.GetStats().health < GameManager.sean.GetStats().maxHealth) {
				super.Use();
				GameManager.sean.AddHealth(10);
				return true;
			}
			return false;
		}
	}

}