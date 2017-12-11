package Entity 
{
	import Items.DoorKey;
	import Items.Drop;
	import Items.Item;
	import Constants.GameManager;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Rixium
	 */
	public class EnemyBase extends EntityBase 
	{
		
		protected var item:Item;
		
		public function EnemyBase() 
		{
			super();
			super.Initialize();
		}
		
		public function SetDrop(item:Item) {
			this.item = item;
		}
		
		protected function DropItem() {
			var drop:Drop = new Drop(x, y, item);
			drop.displayName = item.displayName;
			drop.description = item.description;
			GameManager.gameScreen.GetRoom().AddDrop(drop);
			drop.Initialize();
			drop.UseInitialize();
			item = null;
		}
	}

}