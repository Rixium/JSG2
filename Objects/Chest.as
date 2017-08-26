package Objects
{

	import flash.events.MouseEvent;
	import flash.events.Event;
	import Items.*;
	import Constants.GameManager;
	
	public class Chest extends UsableObject
	{
		
		protected var item:Item;
		
		public function Chest()
		{
			super();
			this.interactable = true;
			this.collidable = true;
			this.useText = "Open";
		}
		
		public function SetItem(item:Item) {
			this.item = item;
		}
		
		public function GetItem() {
			return item;
		}
		
		public function RemoveItem() {
			this.item = null;
		}
		
		protected override function Use():void {
			if(item != null) {
				if(GameManager.sean.GetInventory().HasFreeSpace()) {
					if (GameManager.sean.GetInventory().AddItem(item, false)) {
						item = null;
						dispatchEvent(new Event("itemTaken"));
					} else {
						GameManager.ui.SetDescriptor("You have no space!", false);
					}
				} else {
					GameManager.ui.SetDescriptor("You have no space!", false);
				}
			} else {
				GameManager.ui.SetDescriptor("It's empty!", false);
			}
		}
	}
}