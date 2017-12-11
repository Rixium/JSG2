package Items 
{
	import flash.display.MovieClip;
	import Constants.GameManager;
	/**
	 * ...
	 * @author Rixium
	 */
	public class InventoryBag extends MovieClip
	{
		
		var slots:Array = [];
		
		public function InventoryBag() 
		{
			slots.push(getChildByName("s1"));
			slots.push(getChildByName("s2"));
			slots.push(getChildByName("s3"));
			slots.push(getChildByName("s4"));
			slots.push(getChildByName("s5"));
			slots.push(getChildByName("s6"));
			slots.push(getChildByName("s7"));
			slots.push(getChildByName("s8"));
			slots.push(getChildByName("s9"));
			slots.push(getChildByName("s10"));
			slots.push(getChildByName("s11"));
			slots.push(getChildByName("s12"));
			slots.push(getChildByName("s13"));
			slots.push(getChildByName("s14"));
			slots.push(getChildByName("s15"));
			slots.push(getChildByName("s16"));
			slots.push(getChildByName("s17"));
			slots.push(getChildByName("s18"));
			slots.push(getChildByName("s19"));
			slots.push(getChildByName("s20"));
			slots.push(getChildByName("s21"));
			slots.push(getChildByName("s22"));
			slots.push(getChildByName("s23"));
			slots.push(getChildByName("s24"));
			slots.push(getChildByName("s25"));
			width = 420;
			height = 420;
		}
		
		public function AddItem(item:Item, force:Boolean):Boolean {
			for (var i:int = 0; i < slots.length; i++) {
				var slot:InventorySlot = slots[i] as InventorySlot;
				if (slots[i].GetItem() == null) {
					if(force) {
						slots[i].SetItem(item);
					}
					if(!force) {
						var anim:ItemPickupAnimation = new ItemPickupAnimation(item);
						GameManager.sean.StartGetItem();
						anim = null;
					}
					return true;
				}
			}
			return false;
		}

		public function HasSpace():Boolean {
			for (var i:int = 0; i < slots.length; i++) {
				var slot:InventorySlot = slots[i] as InventorySlot;
				if (slots[i].GetItem() == null) {
					return true;
				}
			}
			return false;
		}
		
	}

}