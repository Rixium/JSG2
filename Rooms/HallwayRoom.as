package Rooms 
{
	/**
	 * ...
	 * @author Rixium
	 */
	
	import Objects.*;
	import Constants.RoomNames;
	
	import Constants.GameManager;
	
	public class HallwayRoom extends Room
	{
		
		
		public function HallwayRoom(lastRoom:int) 
		{
			super();
			this.lastRoom = lastRoom;
			
		}
		
		public override function AddObjects():void {
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;
			
			var door:Door = new Door(973, 100, 125, 321, false, RoomNames.SEANSROOM, RoomNames.HALLWAY);
			var masDoor:Door = new Door(500, 100, 125, 321, true, RoomNames.MASROOM, RoomNames.HALLWAY);
			
			door.displayName = "Door";
			door.description = "Covered in gross green slime.." + door.description;
			door.interactable = true;
			
			masDoor.displayName = "Door";
			masDoor.description = "Covered in gross green slime.." + door.description;
			masDoor.interactable = true;
			
			bLayer.addChild(door);
			bLayer.addChild(masDoor);
			
			doors.push(door);
			doors.push(masDoor);
			
			if (lastRoom != RoomNames.NONE) {
				for (var i:int = 0; i < doors.length; i++) {
					var d:Door = doors[i];
					
					if (d.roomLink == lastRoom) {
						GameManager.sean.x = d.x + d.width / 2;
						GameManager.sean.y = d.y + d.height / 2;
					}
				}
			}
			
		}
		
	}

}