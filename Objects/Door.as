package Objects
{
	import Rooms.Room;
	import Constants.RoomNames;
	import Constants.GameManager;
	
	public class Door extends UsableObject
	{
		
		public var roomLink:int;
		var currentRoom:int
		var locked:Boolean;
		
		public function Door(x:int, y:int, w:int, h:int, locked:Boolean, roomLink:int, currentRoom:int)
		{
			super();
			this.x = x;
			this.y = y;
			this.width = w;
			this.height = h;
			this.interactable = true;
			this.collidable = false;
			this.roomLink = roomLink;
			this.currentRoom = currentRoom;
			this.useText = "To " + RoomNames.GetRoomName(roomLink);
			this.locked = locked;
			
			if(locked) {
				this.description = " and Locked.";
			} else {
				this.description = " and Unlocked.";
			}
		}
		
		protected override function Use():void {
			if(!locked) {
				GameManager.gameScreen.SetRoom(RoomNames.GetRoom(currentRoom, roomLink));
			} else {
				GameManager.ui.SetDescriptor("The Door is Locked..", false);
			}
		}
		
	}
}