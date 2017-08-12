package Objects
{
	import Rooms.Room;
	import Constants.RoomNames;
	
	public class Door extends UsableObject
	{
		
		var roomLink:int;
		
		public function Door(x:int, y:int, w:int, h:int, locked:Boolean, roomLink:int)
		{
			super();
			this.x = x;
			this.y = y;
			this.width = w;
			this.height = h;
			this.interactable = true;
			this.collidable = false;
			this.roomLink = roomLink;
			this.useText = "To " + RoomNames.GetRoomName(roomLink);
			
			if(locked) {
				this.description = " and Locked.";
			} else {
				this.description = " and Unlocked.";
			}
		}
	}
}