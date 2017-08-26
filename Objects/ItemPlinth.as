package Objects 
{
	/**
	 * ...
	 * @author Rixium
	 */
	
	import Items.Item;
	import Constants.GameManager;
	
	public class ItemPlinth extends Chest 
	{

		public function ItemPlinth(x:int, y:int, w:int, h:int) 
		{
			super();
			this.x = x;
			this.y = y;
			this.width = w;
			this.height = h;
			this.interactable = true;
			this.collidable = true;
			this.useText = "Take";
		}
		
		public override function SetItem(item:Item) {
			this.item = item;
			itemHolder.addChild(item);
		}
		
		protected override function Use():void {
			if(item != null) {
				if(GameManager.sean.GetInventory().HasFreeSpace()) {
					if (GameManager.sean.GetInventory().AddItem(item, false)) {
						itemHolder.removeChildAt(0);
						RemoveItem();
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