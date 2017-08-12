package Constants 
{
	/**
	 * ...
	 * @author Rixium
	 */
	public class RoomNames 
	{
		
		public static var SEANSROOM = 0;
		public static var HALLWAY = 1;
		public static var ATTIC = 2;
		public static var LIVINGROOM = 3;
		public static var KITCHEN = 4;
		public static var MASROOM = 5;
		
		public static function GetRoomName(room:int):String {
			switch(room) {
				case SEANSROOM:
					return "Sean's Room";
				case HALLWAY:
					return "Hallway";
				case ATTIC:
					return "Attic";
				case LIVINGROOM:
					return "Living Room";
				case KITCHEN:
					return "Kitchen";
				case MASROOM:
					return "Ma's Room";
				default:
					break;
			}
			
			return "";
		}
		
	}

}