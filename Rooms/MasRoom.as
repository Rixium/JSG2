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
	
	public class MasRoom extends Room
	{
		
		var door:Door = null;
		
		public function MasRoom(lastRoom:int) 
		{
			super();
			this.lastRoom = lastRoom;
		}
		
		public override function AddObjects():void {
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;
			
			if(door == null) {
				door = new Door(1259, 350, 64, 312, false, RoomNames.HALLWAY, RoomNames.MASROOM, DoorTypes.SIDE);
				door.displayName = "Door";
				door.description = "Covered in gross green slime.." + door.description;
				door.interactable = true;
				doors.push(door);
			}
			
			door.Initialize();
			door.UseInitialize();
			
			bLayer.addChild(door);

			if (lastRoom != RoomNames.NONE) {
				for (var i:int = 0; i < doors.length; i++) {
					var d:Door = doors[i];
					
					if (d.roomLink == lastRoom) {
						if(door.doorType != DoorTypes.SIDE) {
						GameManager.sean.x = d.x + d.width / 2;
						GameManager.sean.y = d.y + d.height / 2 + 20;
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