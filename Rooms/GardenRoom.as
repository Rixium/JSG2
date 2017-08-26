package Rooms 
{
	/**
	 * ...
	 * @author Rixium
	 */
	
	import Objects.*;
	import Constants.RoomNames;
	import Entity.Zombie;
	import Weapons.Weapon;
	import flash.accessibility.Accessibility;
	import flash.globalization.Collator;
	
	import Constants.GameManager;
	import Constants.DoorTypes;
	import Constants.Conversations;
	import Constants.WeaponTypes;
	
	public class GardenRoom extends Room
	{
		
		private var door:Door;
		private var house:House;
		private var shed:Shed;
		private var shedDoor:Door;
		
		public function GardenRoom(lastRoom:int) 
		{
			super();
			this.lastRoom = lastRoom;
			
		}
		
		public override function AddEnemies() {
			entityLayer.addChild(new Zombie(700, 800, 20, 100, new Weapon(WeaponTypes.SEPTICSWORD, 10)));
		}
		
		public override function AddObjects():void {
			
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;

			border.mouseEnabled = false;
			
			if (firstVisit) {
				//GameManager.sean.phone.InitiateConversation(Conversations.conversation2);
				firstVisit = false;
				house = new House(1416, 105, 1289, 1178);
				house.displayName = "House";
				house.description = "Home, Sweet home.";
				objects.push(house);
				
				shed = new Shed(265, -11, 440, 552);
				shed.displayName = "Shed";
				shed.description = "An outhouse full of tools.";
				objects.push(shed);
				
				shedDoor = new Door(512, 305, 129, 280, false, RoomNames.SHED, RoomNames.GARDEN, DoorTypes.SHEDDOOR);
				shedDoor.displayName = "Passage";
				shedDoor.description = "An entrance in to the dark shed.";
				shedDoor.interactable = true;
				doors.push(shedDoor);
			}
			
			if(door == null) {
				door = new Door(1795, 1073, 125, 249, false, RoomNames.KITCHEN, RoomNames.GARDEN, DoorTypes.CLEAN);
				door.displayName = "Door";
				door.description = "A door leading to the Kitchen.";
				door.interactable = true;
				doors.push(door);
				
			}
			
			
			
			door.Initialize();
			door.UseInitialize();
			shedDoor.Initialize();
			shedDoor.UseInitialize();
			house.Initialize();
			shed.Initialize();

			bLayer.addChild(shed);
			bLayer.addChild(house);
			bLayer.addChild(door);
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
			
			GameManager.gameScreen.Follow(true);
			//scaleX = .5;
			//scaleY = .5;
			
			bLayer = null;
			fLayer = null;
			
		}
		
	}

}