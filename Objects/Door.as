package Objects
{
	import Rooms.Room;
	import Constants.RoomNames;
	import Constants.GameManager;
	import Constants.ItemTypes;
	import Sounds.DoorCloseSound;
	import Sounds.DoorUnlockSound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import Items.DoorKey;
	
	public class Door extends UsableObject
	{
		
		public var roomLink:int;
		var currentRoom:int
		var locked:Boolean;
		public var doorType:int;
		
		public function Door(x:int, y:int, w:int, h:int, locked:Boolean, roomLink:int, currentRoom:int, doorType:int)
		{
			this.gotoAndStop(doorType);
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
			
			this.doorType = doorType;
			
			
			if(locked) {
				this.description = " and Locked.";
			} else {
				this.description = " and Unlocked.";
			}
		}
		
		protected override function Use():void {
			if (!locked) {
				var closeDoorSound:DoorCloseSound = new DoorCloseSound();;
				var trans:SoundTransform = new SoundTransform(GameManager.soundLevel, 0); 
				var channel:SoundChannel = closeDoorSound.play(0, 1, trans);
				closeDoorSound = null;
				trans = null;
				channel = null;
				GameManager.gameScreen.SetRoom(RoomNames.GetRoom(currentRoom, roomLink));
			} else {
				if (GameManager.sean.GetItem().itemType == ItemTypes.DOORKEY) {
					var key:DoorKey = GameManager.sean.GetItem() as DoorKey;
					if (key.GetDoor() == roomLink) {
						GameManager.ui.SetDescriptor("You unlocked the " + displayName + "..", false);
						var unlockSound:DoorUnlockSound = new DoorUnlockSound();;
						trans = new SoundTransform(GameManager.soundLevel, 0); 
						channel = unlockSound.play(0, 1, trans);
						this.description = " and Unlocked.";
						this.locked = false;
						unlockSound = null;
						trans = null;
						channel = null;
					}  else {
						GameManager.ui.SetDescriptor("That doesn't work..", false);
					}
				} else {
					GameManager.ui.SetDescriptor("The " + displayName + " is Locked..", false);
				}
				
			}
		}
		
	}
}