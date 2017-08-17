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
		
		public function DoorKey(door:int, image:int) 
		{
			super(image, ItemTypes.DOORKEY);
			this.door = door;
			gotoAndStop(image);
		}
		
		public function GetDoor():int {
			return this.door;
		}
		
	}

}