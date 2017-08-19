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
	
	public class KitchenRoom extends Room
	{

		public function KitchenRoom(lastRoom:int) 
		{
			super();
			this.lastRoom = lastRoom;
		}
		
		public override function AddObjects():void {
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;
			
			var door:Door;
			
			if(door == null) {
				door = new Door(120, 61, 125, 312, false, RoomNames.LIVINGROOM, RoomNames.KITCHEN, DoorTypes.CLEAN);
				door.displayName = "Door";
				door.description = "Goes through to the Living Room.";
				door.interactable = true;
				objects.push(door);
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