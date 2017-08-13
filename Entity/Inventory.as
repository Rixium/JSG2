package Entity 
{
	import Items.DoorKey;
	import Items.Item;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import Constants.Keys;
	import Constants.GameManager;
	import flash.events.MouseEvent;
	import Items.InventorySlot;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class Inventory extends MovieClip
	{
		
		protected var slots:Array = [];
		private var inventorySize:int = 9;
		private var sean:Sean;
		public var selectedItem:Item;
		
		public function Inventory(s:Sean) 
		{
			this.sean = s;
			mouseEnabled = true;
			gotoAndStop("visible");
			itemBlocks.addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
		}
		
		public function Initialize() {
			for (var i:int = 0; i < inventorySize; i++) {
				var iBlock:InventorySlot = new InventorySlot(i + 1);
				slots.push(iBlock);
				itemBlocks.addChild(iBlock);
				iBlock = null;
			}
			
		}
		
		
		private function MouseOver(e:MouseEvent):void {
			var slot:InventorySlot = e.target as InventorySlot;
			GameManager.mouseInfo.SetText(slot.GetItem().toString());
			slot = null;
		}
		
		private function MouseOut(e:MouseEvent):void {
			GameManager.mouseInfo.SetText("");
		}
		
		public function AddItem(item:Item):Boolean {
			for (var i:int = 0; i < slots.length; i++) {
				if (slots[i].GetItem() == null) {
					slots[i].SetItem(item);
					slots[i].addEventListener(MouseEvent.MOUSE_OVER, MouseOver);
					selectedItem = slots[i].GetItem();
					return true;
				}
			}
			return false;
		}
		
	}

}