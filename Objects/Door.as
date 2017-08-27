package Objects
{
	import Items.Item;
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
	import Items.DoorKey;
	
	public class Door extends UsableObject
	{
		
		public var roomLink:int;
		var currentRoom:int
		var locked:Boolean;
		public var doorType:int;
		public var wItemToOpen:int;

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

		}
		
		protected override function Use():void {
			if (!locked) {
				var closeDoorSound:DoorCloseSound = new DoorCloseSound();;
				var trans:SoundTransform = new SoundTransform(GameManager.soundLevel, 0); 
				var channel:SoundChannel = closeDoorSound.play(0, 1, trans);
				closeDoorSound = null;
				trans = null;
				channel = null;
				GameManager.gameScreen.SetRoom(currentRoom, roomLink);
			} else {
				if (GameManager.sean.GetInventory().selectedItemSlot.GetItem() != null) {
					
					var canOpen:Boolean = false;
					
					if (GameManager.sean.GetInventory().selectedItemSlot.GetItem().itemType == ItemTypes.WEAPON) {
						var wItem:WeaponItem;
						wItem = GameManager.sean.GetInventory().selectedItemSlot.GetItem() as WeaponItem;
						if (wItem.weaponType == wItemToOpen) {
							canOpen = true;
						}
					}
					
					if (GameManager.sean.GetInventory().selectedItemSlot.GetItem().itemType == ItemTypes.DOORKEY) {
						var key:DoorKey = GameManager.sean.GetInventory().selectedItemSlot.GetItem() as DoorKey;
						if (key.GetDoor() == roomLink) {
							canOpen = true;
						}  else {
							GameManager.ui.SetDescriptor("That doesn't work..", false);
						}
						GameManager.sean.GetInventory().selectedItemSlot.RemoveItem();
						key = null;
					}
					
					if (canOpen) {
						GameManager.ui.SetDescriptor("You unlocked the " + displayName + "..", false);
						var unlockSound:DoorUnlockSound = new DoorUnlockSound();;
						trans = new SoundTransform(GameManager.soundLevel, 0); 
						channel = unlockSound.play(0, 1, trans);
						this.locked = false;
						unlockSound = null;
						trans = null;
						channel = null;
					} else {
						var lockedDoorSound2:LockedDoorSound = new LockedDoorSound();;
						trans = new SoundTransform(GameManager.soundLevel, 0); 
						channel = lockedDoorSound2.play(0, 1, trans);
						lockedDoorSound2 = null;
						trans = null;
						channel = null;
						GameManager.ui.SetDescriptor("The " + displayName + " is Locked..", false);
					}
				} else {
						var lockedDoorSound:LockedDoorSound = new LockedDoorSound();;
						trans = new SoundTransform(GameManager.soundLevel, 0); 
						channel = lockedDoorSound.play(0, 1, trans);
						lockedDoorSound = null;
						trans = null;
						channel = null;
					GameManager.ui.SetDescriptor("The " + displayName + " is Locked..", false);
				}
				
			}
		}
		
	}
}