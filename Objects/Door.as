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
	import UIObjects.CheckConfirm;
	import flash.events.Event;
	import flash.media.SoundChannel;
	import Constants.DoorTypes;
	import flash.media.SoundTransform;
	import Items.DoorKey;
	import flash.media.Sound;
	
	public class Door extends UsableObject
	{
		
		public var roomLink:int;
		var currentRoom:int
		var locked:Boolean;
		public var doorType:int;
		public var wItemToOpen:int;
		var useDoorSound:int;
		
		var checkConfirm:CheckConfirm;

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
		
		public function Unlock() {
			locked = false;
		}
		
		public function Lock() {
			locked = true;
		}
		
		public function SetConfirm() {
				if (checkConfirm == null) {
					checkConfirm = new CheckConfirm();
				}
		}
		
		private function UseConfirm(e:Event):void {
			Use();
		}
		
		protected override function Use():void {
			super.Use();
			if (!locked) {
				var canGo:Boolean = false;
				
				if (checkConfirm != null) {
					if (!checkConfirm.active) {
						checkConfirm = new CheckConfirm();
						GameManager.ui.addChild(checkConfirm);
						checkConfirm.Initialize();
						canGo = checkConfirm.Check();
						checkConfirm.addEventListener("Checked", UseConfirm);
						checkConfirm.active = true;
					} else {
						canGo = checkConfirm.Check();
						checkConfirm.Kill();
						checkConfirm.active = false;
					}
				} else {
					canGo = true;
				}
				
				if(canGo) {
					var closeDoorSound:Sound = DoorTypes.GetSound(doorType);
					var trans:SoundTransform = new SoundTransform(GameManager.soundLevel, 0); 
					var channel:SoundChannel = closeDoorSound.play(0, 1, trans);
					closeDoorSound = null;
					trans = null;
					channel = null;
					GameManager.gameScreen.SetRoom(currentRoom, roomLink);
				}
			} else {
				if(GameManager.sean.GetInventory().selectedItemSlot != null) {
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
							if(canOpen) {
								GameManager.sean.GetInventory().selectedItemSlot.RemoveItem();
								key = null;
							}
						}
						
						if (canOpen) {
							GameManager.ui.SetDescriptor("You unlocked the " + displayName + "..", false);
							var unlockSound:DoorUnlockSound = new DoorUnlockSound();;
							trans = new SoundTransform(GameManager.soundLevel, 0); 
							channel = unlockSound.play(0, 1, trans);
							this.locked = false;
							if (doorType == DoorTypes.HATCHBOTTOM) {
								inside.gotoAndStop(2);
								description = "A ladder leading to the " + RoomNames.GetRoomName(roomLink);
							}
							
							unlockSound = null;
							trans = null;
							channel = null;
						} else {
							if (doorType != DoorTypes.HATCHBOTTOM) {
								var lockedDoorSound2:LockedDoorSound = new LockedDoorSound();;
								trans = new SoundTransform(GameManager.soundLevel, 0); 
								channel = lockedDoorSound2.play(0, 1, trans);
								lockedDoorSound2 = null;
								trans = null;
								channel = null;
								GameManager.ui.SetDescriptor("The " + displayName + " is Locked..", false);
							} else {
								GameManager.ui.SetDescriptor("You need something long to reach that!", false);
							}
						}
					} else {
						if(doorType != DoorTypes.HATCHBOTTOM) {
							var lockedDoorSound:LockedDoorSound = new LockedDoorSound();;
							trans = new SoundTransform(GameManager.soundLevel, 0); 
							channel = lockedDoorSound.play(0, 1, trans);
							lockedDoorSound = null;
							trans = null;
							channel = null;
							GameManager.ui.SetDescriptor("The " + displayName + " is Locked..", false);
						} else {
							GameManager.ui.SetDescriptor("You can't reach that!", false);
						}
					}
				} else {
					if(doorType != DoorTypes.HATCHBOTTOM) {
						lockedDoorSound = new LockedDoorSound();;
						trans = new SoundTransform(GameManager.soundLevel, 0); 
						channel = lockedDoorSound.play(0, 1, trans);
						lockedDoorSound = null;
						trans = null;
						channel = null;
						GameManager.ui.SetDescriptor("The " + displayName + " is Locked..", false);
					} else {
						GameManager.ui.SetDescriptor("You can't reach that!", false);
					}
				}
				
			}
		}
		
	}
}