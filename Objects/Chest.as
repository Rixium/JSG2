package Objects
{

	import flash.events.MouseEvent;
	import Items.*;
	import Constants.GameManager;
	
	public class Chest extends UsableObject
	{
		
		private var item:Item;
		
		public function Chest(x:int, y:int, w:int, h:int)
		{
			super();
			this.y = y;
			this.x = x;
			this.width = w;
			this.height = h;
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