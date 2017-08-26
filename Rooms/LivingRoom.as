package Rooms 
{
	/**
	 * ...
	 * @author Rixium
	 */
	
	import Objects.*;
	import Constants.RoomNames;
	
	import Constants.GameManager;
	import Constants.DoorTypes;
	
	public class LivingRoom extends Room
	{
		
		var door:Door;
		var door2:Door;
		var door3:Door;
		var sofa:Sofa;
		var coffeeTable:CoffeeTable;

		public function LivingRoom(lastRoom:int) 
		{
			super();
			this.lastRoom = lastRoom;
		}
		
		public override function AddObjects():void {
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;
			
			if (firstVisit) {
				firstVisit = false;
				
				sofa = new Sofa(210, 205, 408, 168);
				sofa.displayName = "Sofa";
				sofa.description = "Perfect for TV n' Chill.";
				objects.push(sofa);
				sofa.gotoAndStop(1);
				
				coffeeTable = new CoffeeTable(223, 392, 364, 139);
				coffeeTable.displayName = "Coffee Table";
				coffeeTable.description = "Made for feet.";
				objects.push(coffeeTable);
			}
			
			sofa.Initialize();
			coffeeTable.Initialize();
			
			if(door == null) {
				door = new Door(35, 61, 125, 312, false, RoomNames.KITCHEN, RoomNames.LIVINGROOM, DoorTypes.CLEAN);
				door.displayName = "Door";
				door.description = "Goes through to the Kitchen.";
				door.interactable = true;
				doors.push(door);
			}
			
			door.Initialize();
			door.UseInitialize();
			
			if(door2 == null) {
				door2 = new Door(803, -224, 596, 612, false, RoomNames.HALLWAY, RoomNames.LIVINGROOM, DoorTypes.STAIRSUP);
				door2.collidable = true;
				door2.displayName = "Stairs";
				door2.description = "Heads up to the Hallway.";
				door2.interactable = true;
				objects.push(door2);
				doors.push(door2);
			}
			
			door2.Initialize();
			door2.UseInitialize();
			
			if(door3 == null) {
				door3 = new Door(1120, door2.y + door2.height - 263, 125, 312, false, RoomNames.BASEMENT, RoomNames.LIVINGROOM, DoorTypes.CLEAN);
				door3.displayName = "Door";
				door3.description = "A door to the basement.";
				door3.interactable = true;
				doors.push(door3);
			}
			
			door3.Initialize();
			door3.UseInitialize();
			
			bLayer.addChild(door);
			bLayer.addChild(door2);
			bLayer.addChild(door3);
			bLayer.addChild(sofa);
			bLayer.addChild(coffeeTable);
			
			if (lastRoom != RoomNames.NONE) {
				for (var i:int = 0; i < doors.length; i++) {
					var d:Door = doors[i];
					if (d.roomLink == lastRoom) {
						if (d.doorType != DoorTypes.SIDE) {
							if (d.doorType == DoorTypes.STAIRSUP) {
								GameManager.sean.scaleX = -2;
								GameManager.sean.x = d.x - GameManager.sean.width / 2 - 20;
								GameManager.sean.y = d.y + d.height - GameManager.sean.height / 2;
							} else {
								GameManager.sean.x = d.x + d.width / 2;
								GameManager.sean.y = d.y + d.height / 2 + 20;
							}
						} else {
							GameManager.sean.x = d.x - GameManager.sean.width / 2
							GameManager.sean.y = d.y + GameManager.sean.height / 2;
						}
					}
					
					d = null;
				}
			}
			
			bLayer = null;
			fLayer = null;
			
		}
		
	}

}