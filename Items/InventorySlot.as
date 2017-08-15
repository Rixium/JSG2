package Items 
{
	import fl.motion.Color;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import Constants.GameManager;
	import Constants.Keys;
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

		public function InventorySlot(num:int) 
		{
			super();
			
			this.y = 0;
			width = 7.2;
			this.x = (num - 1) * this.width;
			
			var t:TextField = getChildByName("num") as TextField;
			t.mouseEnabled = false;
			t.text = "" + Keys.KeyToChar[Keys.slots[num - 1]];
			
			addEventListener(MouseEvent.MOUSE_OVER, MouseOver);
			addEventListener(MouseEvent.MOUSE_DOWN, MouseClick);
			
			if(num != 1) {
				glowBox.visible = false;
			} else {
				Select();
			}
			t = null;
		}

		private function MouseOver(e:MouseEvent):void {
			if(GetItem() != null) {
				GameManager.mouseInfo.SetText(GetItem().displayName);
			}
		}
		
		private function MouseClick(e:MouseEvent):void {
				Select();
				if (GetItem() != null) {
					GameManager.ui.SetDescriptor(GetItem().description, false);
				}
		}
		
		public function Select():void {
			if (GameManager.sean.GetInventory().selectedItemSlot != null) {
				GameManager.sean.GetInventory().selectedItemSlot.Deselect();
				glowBox.visible = true;
				GameManager.sean.GetInventory().selectedItemSlot = this;
			} else {
				glowBox.visible = true;
				GameManager.sean.GetInventory().selectedItemSlot = this;
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
			itemLayer.removeChild(item);
			this.item = null;
		}
		
		public function SetItem(item:Item):void {
			this.item = item;
			itemLayer.addChild(item);
			itemLayer.width = 64;
			itemLayer.height = 64;
			item.width = 64;
			item.height = 64;
			item.mouseEnabled = false;
		}
	}

}