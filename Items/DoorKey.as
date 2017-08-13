package Items 
{
	
	import Constants.ItemTypes;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class DoorKey extends Item 
	{
		
		private var door:int;
		
		public function DoorKey(door:int) 
		{
			super();
			this.itemType = ItemTypes.DOORKEY;
			this.door = door;
		}
		
		public function GetDoor():int {
			return this.door;
		}
		
	}

}