package Items 
{
	import Weapons.Weapon;
	import fl.motion.Color;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import Constants.*;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.filters.BitmapFilterQuality;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class InventorySlot extends MovieClip 
	{
		
		var item:Item = null;
		public var selectable;

		public function InventorySlot() 
		{
			super();
			addEventListener(MouseEvent.MOUSE_DOWN, MouseClick);
			glowBox.visible = false;
			selectable = false;
		}
		
		public function SetNumAndPos(num:int) {
			this.y = 0;
			width = 7.2;
			this.x = (num - 1) * this.width;
			
			var t:TextField = getChildByName("num") as TextField;
			t.mouseEnabled = false;
			t.text = "" + Keys.KeyToChar[Keys.slots[num - 1]];
			
			if(num != 1) {
				glowBox.visible = false;
			} else {
				Select();
			}
			t = null;
		}

		private function MouseOut(e:MouseEvent):void {
			if(GetItem() != null) {
				GameManager.mouseInfo.SetText("");
			}
		}
		
		private function MouseOver(e:MouseEvent):void {
			if(GetItem() != null) {
				GameManager.mouseInfo.SetText(GetItem().displayName);
				if (GetItem().itemType == ItemTypes.WEAPON) {
					var wep:WeaponItem = GetItem() as WeaponItem;
					GameManager.ui.SetDescriptor("Damage +" + wep.power + " - " + wep.description, false);
					wep = null;
				} else {
					GameManager.ui.SetDescriptor(GetItem().description, false);
				}
			}
		}
		
		private function MouseClick(e:MouseEvent):void {
				Select();
		}
		
		public function Select():void {
			if (GameManager.sean.GetInventory().selectedItemSlot != null && selectable) {
				GameManager.sean.GetInventory().selectedItemSlot.Deselect();
				glowBox.visible = true;
				GameManager.sean.GetInventory().selectedItemSlot = this;
			} else {
				if(selectable) {
					glowBox.visible = true;
					GameManager.sean.GetInventory().selectedItemSlot = this;
				}
			}
			if (item != null) {
				if(!GameManager.sean.GetInventory().bagOpen && selectable) {
					if (item.itemType == ItemTypes.WEAPON) {
						var itemGet:WeaponItem = item as WeaponItem;
						var weapon:Weapon = new Weapon(itemGet.weaponType, itemGet.power);
						
						GameManager.sean.SetWeapon(weapon);
						weapon = null;
						itemGet = null;
					} else if (item.itemType == ItemTypes.USABLE) {
						var useable:UsableItem = item as UsableItem;
						if(useable.Use()) {
							useable = null;
							RemoveItem();
						}
					}
				} else {
					if (GameManager.sean.GetInventory().SetMouseItem(item)) {
						Deselect();
						item = null;
					}
				}
			} else {
				if (GameManager.sean.GetInventory().GetMouseItem() != null) {
					SetItem(GameManager.sean.GetInventory().GetMouseItem());
					Deselect();
					GameManager.sean.GetInventory().selectedItemSlot = null;
					GameManager.sean.GetInventory().RemoveMouseItem();
				}
			}
		}
		
		public function Deselect():void {
			GameManager.sean.GetInventory().selectedItemSlot = null;
			glowBox.visible = false;
		}
		
		public function GetItem():Item {
			return item;
		}
		
		public function RemoveItem():void {
			removeEventListener(MouseEvent.MOUSE_OVER, MouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, MouseOut);
			itemLayer.removeChild(item);
			this.item = null;
		}
		
		public function SetItem(item:Item):void {this.item = item;
			itemLayer.addChild(item);
			itemLayer.width = 64;
			itemLayer.height = 64;
			item.width = 64;
			item.height = 64;
			item.mouseEnabled = false;
			
			addEventListener(MouseEvent.MOUSE_OVER, MouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
			
			if (GameManager.sean.GetInventory().selectedItemSlot != null) {
				if (GameManager.sean.GetInventory().selectedItemSlot == this) {
					if (item != null) {
						if (item.itemType == ItemTypes.WEAPON) {
							var itemGet:WeaponItem = item as WeaponItem;
							var weapon:Weapon = new Weapon(itemGet.weaponType, itemGet.power);
							
							GameManager.sean.SetWeapon(weapon);
							weapon = null;
							itemGet = null;
						}
					}
				}
			}
		}
	}

}