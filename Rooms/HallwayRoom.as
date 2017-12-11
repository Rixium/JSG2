package Rooms 
{
	/**
	 * ...
	 * @author Rixium
	 */
	
	import Objects.*;
	import Constants.RoomNames;
	import Items.StaminaUpgradeItem;
	import Sounds.MaFight;
	import Sounds.MainSound;
	import flash.accessibility.Accessibility;
	import flash.globalization.Collator;
	
	import Constants.GameManager;
	import Constants.DoorTypes;
	import Constants.Conversations;
	import Constants.WeaponTypes;
	import Constants.RoomTracks;
	
	public class HallwayRoom extends Room
	{
		
		public var door:Door;
		private var staircase:Door;
		private var masDoor:Door;
		private var atticDoor:Door;
		private var hallArt:Art;
		private var hallPlant:HallPlant;
		private var hallCabinet:HallCabinet;
		var startSteps:int;
		var startedConvo:Boolean = false;
		
		public function HallwayRoom(lastRoom:int) 
		{
			super();
			this.lastRoom = lastRoom;
			roomTrack = RoomTracks.MAIN;
			startSteps = GameManager.sean.numSteps;
		}
		
		public override function AddObjects():void {
			
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;
			
			if (firstVisit) {
				firstVisit = false;
				
				hallPlant = new HallPlant(250, 116, 184, 306);
				hallPlant.displayName = "Yucca";
				hallPlant.description = "A beautiful tree.";
				hallPlant.scaleX *= -1;
				hallPlant.x = hallPlant.width + 10;
				objects.push(hallPlant);
				
				hallCabinet = new HallCabinet(1166, 360, 147, 334);
				hallCabinet.displayName = "Cabinet";
				hallCabinet.description = "A nice plant sits on the cabinet.";
				hallCabinet.SetItem(new StaminaUpgradeItem());
				objects.push(hallCabinet);
				
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
					atticDoor.description = "There's a hoop, but I can't reach it.";
					atticDoor.wItemToOpen = WeaponTypes.STICK;
					doors.push(atticDoor);
				}
				if (hallArt == null) {
					hallArt = new Art(734, 130, 130, 109, 1);
					hallArt.displayName = "Painting";
					hallArt.description = "A painting of heaven and hell.. It's upside down.";
				}
				
				if (staircase == null) {
					staircase = new Door(5, 300, 383, 264, false, RoomNames.LIVINGROOM, RoomNames.HALLWAY, DoorTypes.STAIRSHALL);
					staircase.displayName = "Staircase";
					staircase.description = "A staircase to the ground floor.";
					doors.push(staircase);
					objects.push(staircase);
					staircase.collidable = true;
				}
			
				
			}
			
			
			bLayer.addChild(door);
			bLayer.addChild(masDoor);
			bLayer.addChild(hallArt);
			bLayer.addChild(hallPlant);
			bLayer.addChild(atticDoor);
			fLayer.addChild(hallCabinet);
			
			fLayer.addChild(staircase);
			
			hallCabinet.Initialize();
			hallCabinet.UseInitialize();
			
			door.Initialize();
			door.UseInitialize();
			masDoor.Initialize();
			masDoor.UseInitialize();
			atticDoor.Initialize();
			atticDoor.UseInitialize();
			hallPlant.Initialize();
			staircase.Initialize();
			staircase.UseInitialize();
			
			hallArt.Initialize();
				
			
			

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
						} else if (d.doorType == DoorTypes.HATCHBOTTOM) {
							GameManager.sean.x = d.x + d.width / 2;
							GameManager.sean.y = d.y + d.height / 2 + 100;
						}
					}
					 d = null;
				}
			}
			
			bLayer = null;
			fLayer = null;
			
		}
		
		override public function Update():void 
		{
			super.Update();
			
			if (!startedConvo) {
				if(GameManager.sean.numSteps >= startSteps + 10) {
					GameManager.sean.phone.InitiateConversation(Conversations.conversation2);
					startedConvo = true;
				}
			}
		}
	}

}