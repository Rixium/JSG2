package Objects
{

	import Weapons.Weapon;
	import flash.events.MouseEvent;
	import Items.*;
	import Constants.ItemImages;
	import Constants.WeaponTypes;
	import Constants.GameManager;
	import Constants.Keys;
	
	public class Torch extends UsableObject
	{
		
		private var item:Item;
		public var canTake:Boolean;
		var light:Light;
		var lightSize = 600;
		
		public function Torch(x:int, y:int, w:int, h:int)
		{
			super();
			this.y = y;
			this.x = x;
			this.width = w;
			this.height = h;
			this.interactable = true;
			this.useText = "Take";
			var weaponItem:WeaponItem = new WeaponItem(ItemImages.TORCH, WeaponTypes.TORCH, 1);
			weaponItem.displayName = "Torch";
			weaponItem.description = "It's fiery, but not very strong.";
			this.item = weaponItem;
			weaponItem = null;
			gotoAndPlay("Torch");
			light = new Light(x - lightSize / 2, y - lightSize / 2, lightSize, lightSize);
			GameManager.gameScreen.GetRoom().lightMask.addChild(light);
		}
		
		public function SetItem(item:Item) {
			this.item = item;
		}
		
		public function GetItem() {
			return item;
		}
		
		public function RemoveItem() {
			gotoAndStop("Empty");
			this.item = null;
		}
		
		protected override function Use():void {
			if(canTake) {
				if(item != null) {
					if(GameManager.sean.GetInventory().HasFreeSpace()) {
						if (GameManager.sean.GetInventory().AddItem(item, item.forcePickup)) {
							GameManager.gameScreen.GetRoom().lightMask.removeChild(light);
							this.useText = "Place";
							var character:String = Keys.GetDictionary()[Keys.USE];
							GameManager.ui.SetDescriptor("'" + character + "' - " + useText, true);
							character = null;
							gotoAndStop("Empty");
							item = null;
						} else {
							GameManager.ui.SetDescriptor("You have no space!", false);
						}
					} else {
						GameManager.ui.SetDescriptor("You have no space!", false);
					}
				} else {
					if (GameManager.sean.GetWeapon() != null) {
						if (GameManager.sean.GetWeapon().weaponType == WeaponTypes.TORCH) {
							GameManager.sean.RemoveWeapon();
							GameManager.gameScreen.GetRoom().lightMask.addChild(light);
							var itemToRemove:WeaponItem = new WeaponItem(ItemImages.TORCH, WeaponTypes.TORCH, 1);
							itemToRemove.displayName = "Torch";
							itemToRemove.description = "It's fiery, but not very strong.";
							itemToRemove.forcePickup = true;
							GameManager.sean.GetInventory().RemoveFrom(itemToRemove);
							this.item = itemToRemove;
							itemToRemove = null;
							this.useText = "Take";
							character = Keys.GetDictionary()[Keys.USE];
							GameManager.ui.SetDescriptor("'" + character + "' - " + useText, true);
							character = null;
							gotoAndPlay("Torch");
						} else {
							GameManager.ui.SetDescriptor("That won't go there!", false);
						}
					} else {
						GameManager.ui.SetDescriptor("You can't place nothing..", false);
					}
				}
			} else {
				GameManager.ui.SetDescriptor("It's held in tight.", false);
			}
		}
	}
}