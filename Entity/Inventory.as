package Entity 
{
	import Items.DoorKey;
	import Items.Item;
	import Items.ItemPickupAnimation;
	import Items.WeaponItem;
	import Weapons.Weapon;
	import fl.motion.Color;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import Constants.Keys;
	import Constants.GameManager;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import Items.InventorySlot;
	import Constants.ItemTypes;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class Inventory extends MovieClip
	{
		
		protected var slots:Array = [];
		private var inventorySize:int = 9;
		private var sean:Sean;
		private var currentSelected = 0;
		public var selectedItemSlot:InventorySlot;
		
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
			}
		}

		private function MouseOut(e:MouseEvent):void {
			GameManager.mouseInfo.SetText("");
			GameManager.ui.SetDescriptor("", true);
		}
		
		public function AddItem(item:Item, force:Boolean):Boolean {
			for (var i:int = 0; i < slots.length; i++) {
				if (slots[i].GetItem() == null) {
					if(force) {
						slots[i].SetItem(item);
					}
					if(!force) {
						var anim:ItemPickupAnimation = new ItemPickupAnimation(item);
						anim = null;
					}
					return true;
				}
			}
			return false;
		}
		
		public function SetSelectedItem(itemSlot:InventorySlot) {
			itemSlot.Select();
		}
		
		public function HasFreeSpace():Boolean {
			for (var i:int = 0; i < slots.length; i++) {
				if (slots[i].GetItem() == null) {
					return true;
				}
			}
			return false;
		}
		
		
		public function SetSlot(slot:int) {
			slots[slot].Select();
		}
		
		public function RemoveFrom(toRemove:Item) {
			for (var i:int = 0; i < slots.length; i++) {
				if (slots[i].GetItem() != null) {
					if (toRemove.itemType == ItemTypes.WEAPON) {
						var toRemoveChecked:WeaponItem = toRemove as WeaponItem;
						var item:Item = slots[i].GetItem();
						if (item.itemType == ItemTypes.WEAPON) {
							var weapon:WeaponItem = item as WeaponItem;
							if (weapon.weaponType == toRemoveChecked.weaponType) {
								slots[i].RemoveItem();
							}
						}
					}
				}
			}
		}
		
	}

}