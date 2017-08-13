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
	
	public class HallwayRoom extends Room
	{
		
		private var door:Door;
		private var masDoor:Door;
		private var atticDoor:Door;
		public function HallwayRoom(lastRoom:int) 
		{
			super();
			this.lastRoom = lastRoom;
			
		}
		
		public override function AddObjects():void {
			
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;
			
			if(door == null) {
				door = new Door(973, 89, 125, 312, false, RoomNames.SEANSROOM, RoomNames.HALLWAY, DoorTypes.CLEAN);
				door.displayName = "Door";
				door.description = "A door leading to Sean's Room.." + door.description;
				door.interactable = true;
				doors.push(door);
				
			}
			if(masDoor == null) {
				masDoor = new Door(500, 89, 125, 312, true, RoomNames.MASROOM, RoomNames.HALLWAY, DoorTypes.SLIME);
				masDoor.displayName = "Door";
				masDoor.description = "Covered in gross green slime.." + masDoor.description;
				masDoor.interactable = true;
				doors.push(masDoor);
				
			}
			if(atticDoor == null) {
				atticDoor = new Door(726, 28, 145, 386, true, RoomNames.ATTIC, RoomNames.HALLWAY, DoorTypes.HATCHBOTTOM);
				atticDoor.displayName = "Hatch";
				atticDoor.description = "A hatch leading to the Attic.." + atticDoor.description;
				doors.push(atticDoor);
			}
			
			door.Initialize();
			door.UseInitialize();
			masDoor.Initialize();
			masDoor.UseInitialize();
			atticDoor.Initialize();
			atticDoor.UseInitialize();
				
			bLayer.addChild(atticDoor);
			bLayer.addChild(door);
			bLayer.addChild(masDoor);

			if (lastRoom != RoomNames.NONE) {
				for (var i:int = 0; i < doors.length; i++) {
					var d:Door = doors[i];
					
					if (d.roomLink == lastRoom) {
						GameManager.sean.x = d.x + d.width / 2;
						GameManager.sean.y = d.y + d.height / 2 + 20;
					}
					 d = null;
				}
			}
			
			bLayer = null;
			fLayer = null;
			
		}
		
	}

}