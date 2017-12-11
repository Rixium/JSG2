package Objects
{
	import Constants.Conversations;
	import Items.WeaponItem;
	import Rooms.Room;
	import Constants.RoomNames;
	import Constants.GameManager;
	import Constants.ItemTypes;
	import Sounds.DoorCloseSound;
	import Sounds.DoorUnlockSound;
	import Sounds.LockedDoorSound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.Sound;
	import Items.DoorKey;
	import Constants.DoorTypes;
	import Constants.ItemImages;
	import Constants.WeaponTypes;
	
	public class SpecialDoor extends Door
	{
		
		private var open = false;
		private var used = false;
		
		public function SpecialDoor(x:int, y:int, w:int, h:int, locked:Boolean, roomLink:int, currentRoom:int)
		{
			super(x, y, w, h, locked, roomLink, currentRoom, DoorTypes.SPECIALDOOR);
			doorType = DoorTypes.SPECIALDOOR;
			this.gotoAndStop(doorType);
			this.x = x;
			this.y = y;
			this.width = w;
			this.height = h;
			this.interactable = false;
			this.collidable = false;
			this.roomLink = roomLink;
			this.currentRoom = currentRoom;
			this.useText = "To " + RoomNames.GetRoomName(roomLink);
			this.locked = locked;
			this.readyToUse = false;
			
			this.doorType = doorType;
			gotoAndStop(DoorTypes.SPECIALDOOR);
			door.gotoAndStop("locked");
			this.useText = "???";
		}
		
		public function Open():void {
				if (locked) {
					if (!open) {
						interactable = true;
						open = true;
						locked = false;
						door.gotoAndPlay("opening");
						readyToUse = true;
					}
				}
		}
		
		protected override function Use():void {
			super.Use();
			if (door.currentLabel == "open") {
				var closeDoorSound:Sound = DoorTypes.GetSound(doorType);
				var trans:SoundTransform = new SoundTransform(GameManager.soundLevel, 0); 
				var channel:SoundChannel = closeDoorSound.play(0, 1, trans);
				closeDoorSound = null;
				trans = null;
				channel = null;
				
				if (this.useText == "???") {
					this.useText = "To Treasure Room";
				}
				GameManager.gameScreen.SetRoom(currentRoom, roomLink);
			} else if (used) {
				GameManager.ui.SetDescriptor("You already looted the treasure room.", false);
			}
		}
		
	}
}