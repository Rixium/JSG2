package Rooms 
{
	/**
	 * ...
	 * @author Rixium
	 */
	
	import Objects.*;
	import Constants.RoomNames;
	import Items.WeaponItem;
	import flash.accessibility.Accessibility;
	import flash.events.Event;
	import flash.globalization.Collator;
	
	import Constants.GameManager;
	import Constants.DoorTypes;
	import Constants.Conversations;
	import Constants.ItemImages;
	import Constants.WeaponTypes;
	
	public class ShedRoom extends Room
	{

		private var shedDoor:Door;
		var crate:Crate;
		
		public function ShedRoom(lastRoom:int) 
		{
			super();
			this.lastRoom = lastRoom;
			
		}
		
		private function InitiateEvent(e:Event) {
				RoomNames.GARDENINSTANCE.AddEnemies();
				crate.removeEventListener("itemTaken", InitiateEvent);
				window.gotoAndPlay("animate");
		}
		
		public override function AddObjects():void {
			
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;

			if (firstVisit) {
				//GameManager.sean.phone.InitiateConversation(Conversations.conversation2);
				firstVisit = false;

				shedDoor = new Door(434, 65, 125, 312, false, RoomNames.GARDEN, RoomNames.SHED, DoorTypes.SHEDDOOR);
				shedDoor.displayName = "Passage";
				shedDoor.description = "An entrance to the garden.";
				shedDoor.interactable = true;
				doors.push(shedDoor);
				
				var item:WeaponItem = new WeaponItem(ItemImages.STICK, WeaponTypes.STICK, 5);
				item.displayName = "Stick";
				item.description = "A stick with a hook."
				
				crate = new Crate(884, 244, 112, 235);
				crate.displayName = "Crate";
				crate.description = "Full of bits and bobs.";
				objects.push(crate);
				
				crate.SetItem(item);
				crate.addEventListener("itemTaken", InitiateEvent);
				
				item = null;
			}

			shedDoor.Initialize();
			shedDoor.UseInitialize();

			crate.Initialize();
			crate.UseInitialize();
			
			bLayer.addChild(crate);
			bLayer.addChild(shedDoor);

			if (lastRoom != RoomNames.NONE) {
				for (var i:int = 0; i < doors.length; i++) {
					var d:Door = doors[i];
					
					if (d.roomLink == lastRoom) {
						GameManager.sean.x = d.x + d.width / 2;
						GameManager.sean.y = d.y + d.height / 2 + 20;
						
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