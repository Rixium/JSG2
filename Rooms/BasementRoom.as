package Rooms 
{
	/**
	 * ...
	 * @author Rixium
	 */
	
	import Objects.*;
	import Constants.RoomNames;
	import Entity.Brazier;
	
	import Constants.GameManager;
	import Constants.DoorTypes;
	import Constants.Conversations;
	import flash.events.Event;
	
	public class BasementRoom extends Room
	{

		var torch:Torch;
		var torch2:Torch;
		
		var door:Door;
		var brazier1:Brazier;
		var brazier2:Brazier;
		var specialDoor:SpecialDoor;
		var opening:Boolean = false;
		var startX:int;
		var startY:int;
		var goingLeft:Boolean = true;
		var goingRight:Boolean = false;
		
		public function BasementRoom(lastRoom:int) 
		{
			super();
			this.lastRoom = lastRoom;
		}
		
		public override function AddObjects():void {
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;
			
			
			
			if (firstVisit) {
				firstVisit = false;
				GameManager.sean.phone.InitiateConversation(Conversations.conversation3);
				
				
				
				specialDoor = new SpecialDoor(1280 / 2 - 268 / 2, 98, 268, 268, true, RoomNames.SPECIALROOM, RoomNames.BASEMENT);
				specialDoor.displayName = "Door";
				specialDoor.description = "A hidden door..";
				doors.push(specialDoor);
				
				brazier1 = new Brazier(372, 145, 104, 219);
				brazier2 = new Brazier(804, 145, 104, 219);
				
				torch2 = new Torch(1136, 142, 103, 305);
				torch2.displayName = "Torch";
				torch2.description = "It's shining bright.";
			}

			specialDoor.Initialize();
			specialDoor.UseInitialize();
				
			if(door == null) {
				door = new Door(1259, 350, 64, 312, false, RoomNames.LIVINGROOM, RoomNames.BASEMENT, DoorTypes.SIDE);
				door.displayName = "Door";
				door.description = "Returns to the living room.";
				door.interactable = true;
				doors.push(door);
			}
			
			door.Initialize();
			door.UseInitialize();
			
			if (torch == null) {
				torch = new Torch(120, 142, 103, 305);
				torch.displayName = "Torch";
				torch.description = "It's shining bright.";
				torch.canTake = true;
			}
			
			brazier1.Initialize();
			brazier2.Initialize();
			
			torch.Initialize();
			torch.UseInitialize();
			
			torch2.Initialize();
			torch2.UseInitialize();
			torch2.canTake = false;
			
			bLayer.addChild(torch);
			bLayer.addChild(torch2);
			bLayer.addChild(door);
			bLayer.addChild(specialDoor);
			entityLayer.addChild(brazier1);
			entityLayer.addChild(brazier2);
			
			if (lastRoom != RoomNames.NONE && doors.length > 0) {
				for (var i:int = 0; i < doors.length; i++) {
					var d:Door = doors[i];
					
					if (d.roomLink == lastRoom) {
						if (d.doorType != DoorTypes.SIDE) {
							if(d.doorType != DoorTypes.SPECIALDOOR) {
								GameManager.sean.x = d.x + d.width / 2;
								GameManager.sean.y = d.y + d.height / 2 + 20;
							} else {
								GameManager.sean.x = d.x + d.width / 2;
								GameManager.sean.y = d.y + d.height / 2 - 50;
							}
						} else {
							GameManager.sean.x = d.x - GameManager.sean.width / 2
							GameManager.sean.y = d.y + GameManager.sean.height / 2;
						}
					}
					
					d = null;
				}
			} else {
				GameManager.sean.x = GameManager.main.stage.stageWidth / 2;
				GameManager.sean.y = GameManager.main.stage.stageHeight / 2;
			}
			
			
			basementBorder.mouseEnabled = false;
			addEventListener(Event.ENTER_FRAME, CheckDoors);
			bLayer = null;
			fLayer = null;
			
		}
		
		private function CheckDoors(e:Event) {
			if (brazier1.on && brazier2.on && !opening && torch.GetItem() != null) {
				torch.canTake = false;
				opening = true;
				specialDoor.Open();
				startX = x;
				startY = y;
			} else if (opening && specialDoor.door.currentLabel != "open") {
				Shake();
			} else if(specialDoor.door.currentLabel == "open") {
				this.x = startX;
				this.y = startY;
				removeEventListener(Event.ENTER_FRAME, CheckDoors);
			}
		}
		
		private function Shake() {
			if (this.x > startX - 3 && goingLeft) {
				x -= 2;
			} else if (this.x < startX + 3 && goingRight) {
				x += 2;
			}
			
			if (this.x <= startX - 3) {
				goingLeft = false;
				goingRight = true;
			} else if (this.x >= startX + 3) {
				goingLeft = true;
				goingRight = false;
			}
		}
		
	}

}