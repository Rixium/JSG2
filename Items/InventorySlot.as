package Items 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import Constants.GameManager;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class InventorySlot extends MovieClip 
	{
		
		var item:Item;
		
		public function InventorySlot(num:int) 
		{
			super();
			
			this.y = 0;
			width = 7.2;
			this.x = (num - 1) * this.width;

			var t:TextField = getChildByName("num") as TextField;
			t.text = num.toString();
			t = null;
		}

		public function GetItem():Item {
			return item;
		}
		
		public function RemoveItem():void {
			this.removeChild(item);
			this.item = null;
		}
		
		public function SetItem(item:Item):void {
			this.item = item;
			this.addChild(item);
			item.width = this.width;
			item.height = this.height;
		}
	}

}