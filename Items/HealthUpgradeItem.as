package Items 
{
	import Entity.EntityBase;
	import Constants.GameManager;
	import Constants.ItemImages;
	import Sounds.UpgradeSound;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class HealthUpgradeItem extends UsableItem
	{
		
		public function HealthUpgradeItem() 
		{
			super(ItemImages.HEALTHUPGRADE);
			displayName = "Healthifier";
			description = "Improves your base health.";
			useSound = new UpgradeSound();
		}
		
		public override function Use():Boolean {
			super.Use();
			GameManager.ui.UpgradeHealth(10);
			GameManager.sean.GetStats().maxHealth += 10;
			GameManager.sean.GetStats().health += 10;
			
			GameManager.healthUpgrades++;
			
			if (GameManager.healthUpgrades >= 3) {

			}
			return true;
		}
		
	}

}