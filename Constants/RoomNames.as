package Constants 
{

	import Rooms.*;
	
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
		public static var BASEMENT = 6;
		public static var GARDEN = 7;
		public static var SHED = 8;
		public static var SPECIALROOM = 9;
		
		public static var SEANINSTANCE:SeansRoom = null;
		public static var HALLINSTANCE:HallwayRoom = null;
		public static var MASINSTANCE:MasRoom = null;
		public static var LIVINGINSTANCE:LivingRoom = null;
		public static var KITCHENINSTANCE:KitchenRoom = null;
		public static var BASEMENTINSTANCE:BasementRoom = null;
		public static var GARDENINSTANCE:GardenRoom = null;
		public static var SHEDINSTANCE:ShedRoom = null;
		public static var SPECIALINSTANCE:SpecialRoom = null;
		public static var ATTICINSTANCE:AtticRoom = null;
		
		public static var lastRoom:int;
		
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
				case BASEMENT:
					return "Basement";
				case GARDEN:
					return "Garden";
				case SHED:
					return "Shed";
				case SPECIALROOM:
					return "";
				default:
					break;
			}
			
			return "";
		}
		
		public static function ClearRoom(room:int) {
				switch(room) {
					case SPECIALROOM:
						SPECIALINSTANCE = null;
						break;
					case ATTIC:
						ATTICINSTANCE = null;
						break;
					default:
						break;
				}
		}
		
		public static function GetRoom(currentRoom:int, room:int):Room {
			lastRoom = room;
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
					if(ATTICINSTANCE == null) {
						ATTICINSTANCE = new AtticRoom(currentRoom);
					} else {
						ATTICINSTANCE.lastRoom = currentRoom; 
					}
					return ATTICINSTANCE;
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
				case BASEMENT:
					if(BASEMENTINSTANCE == null) {
						BASEMENTINSTANCE = new BasementRoom(currentRoom);
					} else {
						BASEMENTINSTANCE.lastRoom = currentRoom; 
					}
					return BASEMENTINSTANCE;
				case GARDEN:
					if(GARDENINSTANCE == null) {
						GARDENINSTANCE = new GardenRoom(currentRoom);
					} else {
						GARDENINSTANCE.lastRoom = currentRoom; 
					}
					return GARDENINSTANCE;
				case SHED:
					if (SHEDINSTANCE == null) {
						SHEDINSTANCE = new ShedRoom(currentRoom);
					} else {
						SHEDINSTANCE.lastRoom = currentRoom;
					}
					return SHEDINSTANCE;
				case SPECIALROOM:
					if (SPECIALINSTANCE == null) {
						SPECIALINSTANCE = new SpecialRoom(currentRoom);
					} else {
						SPECIALINSTANCE.lastRoom = currentRoom;
					}
					return SPECIALINSTANCE;
				default:
					break;
			}
			
			return null;
		}
	}

}