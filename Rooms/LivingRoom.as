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

		public function LivingRoom(lastRoom:int) 
		{
			super();
			this.lastRoom = lastRoom;
		}
		
		public override function AddObjects():void {
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;
			
			var door:Door;
			var door2:Door;
			
			if(door == null) {
				door = new Door(120, 61, 125, 312, false, RoomNames.KITCHEN, RoomNames.LIVINGROOM, DoorTypes.CLEAN);
				door.displayName = "Door";
				door.description = "Goes through to the Kitchen.";
				door.interactable = true;
				objects.push(door);
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
			
			bLayer.addChild(door);
			bLayer.addChild(door2);
			
			if (lastRoom != RoomNames.NONE) {
				for (var i:int = 0; i < doors.length; i++) {
					var d:Door = doors[i];
					if (d.roomLink == lastRoom) {
						if (d.doorType != DoorTypes.SIDE) {
							if (d.doorType == DoorTypes.STAIRSUP) {
								GameManager.sean.scaleX = -2;
								GameManager.sean.x = d.x - GameManager.sean.width / 2;
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