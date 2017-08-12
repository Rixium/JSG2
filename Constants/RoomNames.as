package Constants 
{
	import Rooms.HallwayRoom;
	import Rooms.Room;
	import Rooms.SeansRoom;
	/**
	 * ...
	 * @author Rixium
	 */
	public class RoomNames 
	{
		
		public static var NONE = -1;
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
		
		public static function GetRoom(currentRoom:int, room:int):Room {
			switch(room) {
				case SEANSROOM:
					return new SeansRoom(currentRoom);
				case HALLWAY:
					return new HallwayRoom(currentRoom);
				case ATTIC:
					break;
				case LIVINGROOM:
					break;
				case KITCHEN:
					break;
				case MASROOM:
					break;
				default:
					break;
			}
			
			return null;
		}
		
	}

}