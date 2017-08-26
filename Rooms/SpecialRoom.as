package Rooms 
{
	/**
	 * ...
	 * @author Rixium
	 */
	
	import Objects.*;
	import Constants.RoomNames;
	import flash.accessibility.Accessibility;
	import flash.globalization.Collator;
	
	import Constants.GameManager;
	import Constants.DoorTypes;
	import Constants.Conversations;
	import Items.WeaponItem;
	import Constants.ItemImages;
	import Constants.WeaponTypes;
		
	
	public class SpecialRoom extends Room
	{

		private var exitDoor:SpecialDoor;
		private var plinth:ItemPlinth;
		
		public function SpecialRoom(lastRoom:int) 
		{
			super();
			this.lastRoom = lastRoom;
		}
		
		public override function AddObjects():void {
			
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;

			if (firstVisit) {
				//GameManager.sean.phone.InitiateConversation(Conversations.conversation2);
				firstVisit = false;

				exitDoor = new SpecialDoor(1280 / 2 - 268 / 2, 246 - 268 + 50, 268, 268, false, RoomNames.BASEMENT, RoomNames.SPECIALROOM);
				exitDoor.displayName = "Exit";
				exitDoor.description = "Return to the Basement.";
				exitDoor.interactable = true;
				doors.push(exitDoor);
				exitDoor.readyToUse = true;
				exitDoor.useText = "To Basement";
				
				plinth = new ItemPlinth(598, 350, 82, 228);
				var weapon:WeaponItem = new WeaponItem(ItemImages.SEPTICSWORD, WeaponTypes.SEPTICSWORD, 10);
				weapon.displayName = "Septic Sword";
				weapon.description = "The legendary septic sword.";
				GameManager.sean.phone.InitiateConversation(Conversations.septicSwordConvo);
				plinth.SetItem(weapon);
				weapon = null;
				plinth.displayName = "Plinth";
				plinth.description = "Holder of an epic item.";
				objects.push(plinth);
			}

			plinth.Initialize();
			plinth.UseInitialize();
			exitDoor.Initialize();
			exitDoor.UseInitialize();

			bLayer.addChild(exitDoor);
			fLayer.addChild(plinth);
			exitDoor.door.gotoAndStop("open");

			if (lastRoom != RoomNames.NONE) {
				for (var i:int = 0; i < doors.length; i++) {
					var d:Door = doors[i];
					
					if (d.roomLink == lastRoom) {
						if(d.doorType != DoorTypes.SPECIALDOOR) {
								GameManager.sean.x = d.x + d.width / 2;
								GameManager.sean.y = d.y + d.height / 2 + 20;
						} else {
							GameManager.sean.x = d.x + d.width / 2;
							GameManager.sean.y = d.y + d.height / 2 - 50;
						}
						if (d.doorType == DoorTypes.STAIRSHALL) {
							GameManager.sean.x = d.x + d.width
							GameManager.sean.y = d.y + d.height / 2 - 20;
							GameManager.sean.scaleX = 2;
						}
					}
					
					
						
					 d = null;
				}
			}
			
			GameManager.gameScreen.Follow(false);
			//scaleX = .5;
			//scaleY = .5;
			
			bLayer = null;
			fLayer = null;
			
		}
		
	}

}