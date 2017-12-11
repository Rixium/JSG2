package Items 
{
	import Objects.Chest;
	import Constants.GameManager;
	import flash.events.Event;
	/**
	 * ...
	 * @author Rixium
	 */
	public class Drop extends Chest
	{

		public var dropNum:int;
		
		public function Drop(x:int, y:int, item:Item ) 
		{
			super();
			this.x = x;
			this.y = y;
			itemHolder.addChild(item);
			SetItem(item);
			collidable = false;
			this.useText = "Take";
		}
		
		protected override function Use():void {
			if(item != null) {
				if(GameManager.sean.GetInventory().HasFreeSpace()) {
					if (GameManager.sean.GetInventory().AddItem(item, false)) {
						item = null;
						dispatchEvent(new Event("itemTaken"));
						GameManager.gameScreen.GetRoom().RemoveDrop(this);
						GameManager.ui.SetDescriptor("", true);
						parent.removeChild(this);
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