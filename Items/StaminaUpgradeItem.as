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
	public class StaminaUpgradeItem extends UsableItem
	{
		
		public function StaminaUpgradeItem() 
		{
			super(ItemImages.STAMINAUPGRADE);
			displayName = "Stamina Syrup";
			description = "Improves your base stamina.";
			useSound = new UpgradeSound();
		}
		
		public override function Use():Boolean {
			super.Use();
			GameManager.ui.UpgradeStamina(10);
			GameManager.sean.GetStats().maxStamina += 10;
			GameManager.sean.GetStats().stamina += 10;
			
			GameManager.staminaUpgrades++;
			
			if (GameManager.staminaUpgrades >= 3) {
				
			}
			return true;
		}
		
	}

}