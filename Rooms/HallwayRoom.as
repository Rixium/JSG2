package Rooms 
{
	/**
	 * ...
	 * @author Rixium
	 */
	
	import Objects.*;
	import Constants.RoomNames;
	import flash.globalization.Collator;
	
	import Constants.GameManager;
	import Constants.DoorTypes;
	import Constants.Conversations;
	
	public class HallwayRoom extends Room
	{
		
		private var door:Door;
		private var masDoor:Door;
		private var atticDoor:Door;
		private var hallArt:Art;
		
		public function HallwayRoom(lastRoom:int) 
		{
			super();
			this.lastRoom = lastRoom;
			
		}
		
		public override function AddObjects():void {
			
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;
			
			if (firstVisit) {
				GameManager.sean.phone.InitiateConversation(Conversations.conversation2);
				firstVisit = false;
			}
			
			if(door == null) {
				door = new Door(973, 89, 125, 312, false, RoomNames.SEANSROOM, RoomNames.HALLWAY, DoorTypes.CLEAN);
				door.displayName = "Door";
				door.description = "A door leading to Sean's Room..";
				door.interactable = true;
				doors.push(door);
				
			}
			if(masDoor == null) {
				masDoor = new Door(500, 89, 125, 312, true, RoomNames.MASROOM, RoomNames.HALLWAY, DoorTypes.SLIME);
				masDoor.displayName = "Door";
				masDoor.description = "Covered in gross green slime..";
				masDoor.interactable = true;
				doors.push(masDoor);
				
			}
			if(atticDoor == null) {
				atticDoor = new Door(726, 28, 145, 386, true, RoomNames.ATTIC, RoomNames.HALLWAY, DoorTypes.HATCHBOTTOM);
				atticDoor.displayName = "Hatch";
				atticDoor.description = "A hatch leading to the Attic..";
				doors.push(atticDoor);
			}
			if (hallArt == null) {
				hallArt = new Art(734, 130, 130, 109);
				hallArt.displayName = "Painting";
				hallArt.description = "A painting of heaven and hell.. It's upside down.";
			}
			
			door.Initialize();
			door.UseInitialize();
			masDoor.Initialize();
			masDoor.UseInitialize();
			atticDoor.Initialize();
			atticDoor.UseInitialize();
			
			hallArt.Initialize();
				
			bLayer.addChild(atticDoor);
			bLayer.addChild(door);
			bLayer.addChild(masDoor);
			bLayer.addChild(hallArt);

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