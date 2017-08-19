package Constants 
{
	import Rooms.HallwayRoom;
	import Rooms.KitchenRoom;
	import Rooms.LivingRoom;
	import Rooms.MasRoom;
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
		
		private static var SEANINSTANCE:SeansRoom = null;
		private static var HALLINSTANCE:HallwayRoom = null;
		private static var MASINSTANCE:MasRoom = null;
		private static var LIVINGINSTANCE:LivingRoom = null;
		private static var KITCHENINSTANCE:KitchenRoom = null;
		
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
					if(SEANINSTANCE == null) {
						SEANINSTANCE = new SeansRoom(currentRoom);
					} else {
						SEANINSTANCE.lastRoom = currentRoom; 
					}
					return SEANINSTANCE;
				case HALLWAY:
					if(HALLINSTANCE == null) {
						HALLINSTANCE = new HallwayRoom(currentRoom);
					} else {
						HALLINSTANCE.lastRoom = currentRoom; 
					}
					return HALLINSTANCE;
				case ATTIC:
					break;
				case LIVINGROOM:
					if (LIVINGINSTANCE == null) {
						LIVINGINSTANCE = new LivingRoom(currentRoom);
					} else {
						LIVINGINSTANCE.lastRoom = currentRoom;
					}
					return LIVINGINSTANCE;
				case KITCHEN:
					if (KITCHENINSTANCE == null) {
						KITCHENINSTANCE = new KitchenRoom(currentRoom);
					} else {
						KITCHENINSTANCE.lastRoom = currentRoom;
					}
					return KITCHENINSTANCE;
				case MASROOM:
					if(MASINSTANCE == null) {
						MASINSTANCE = new MasRoom(currentRoom);
					} else {
						MASINSTANCE.lastRoom = currentRoom; 
					}
					return MASINSTANCE;
				default:
					break;
			}
			
			return null;
		}
	}

}