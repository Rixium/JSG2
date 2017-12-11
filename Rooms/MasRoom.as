package Rooms 
{
	/**
	 * ...
	 * @author Rixium
	 */
	
	import Objects.*;
	import Constants.RoomNames;
	import Items.DoorKey;
	import Items.HealthUpgradeItem;
	import Items.StaminaUpgradeItem;
	import flash.events.Event;
	
	
	import Constants.*;
	
	public class MasRoom extends Room
	{
		
		var door:Door = null;
		var window:WindowObject;
		var bed:MasBed;
		var lightSize:int = 1400;
		var cabinet1:MaCabinet;
		var cabinet2:MaCabinet;
		var startSteps:int = 0;
		var firstCall:Boolean = true;
		var dressingTable:DressingTable;
		var startSecond:Boolean = false;
		var book:Book;
		
		public function MasRoom(lastRoom:int) 
		{
			super();
			this.lastRoom = lastRoom;
			startSteps = GameManager.sean.numSteps;
			roomTrack = RoomTracks.MAROOMAMBIENCE;
		}
		
		override public function Update():void 
		{
			super.Update();
			
			if (firstCall) {
				if (GameManager.sean.numSteps > startSteps + 10) {
					GameManager.sean.phone.InitiateConversation(Conversations.masRoomConvo1);
					firstCall = false;
				}
			} else if (startSecond) {
				if (GameManager.sean.numSteps > startSteps + 10) {
					GameManager.sean.phone.InitiateConversation(Conversations.masRoomConvo2);
					startSecond = false;
				}
			}
		}
		
		private function WindowUsed(e:Event) {
			roomTrack = RoomTracks.MAROOMSHOCK;
			GameManager.gameScreen.musicManager.PlayTrack(roomTrack);
			startSteps = GameManager.sean.numSteps;
			startSecond = true;
		}
		
		public override function AddObjects():void {
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;
			
			if (firstVisit) {
				firstVisit = false;
				
				var light:Light = new Light(GameManager.main.stage.stageWidth / 2 - lightSize / 2, GameManager.main.stage.stageHeight / 2 - lightSize / 2, lightSize, lightSize);
				light.canFlash = false;
				lightMask.addChild(light);
				light = null;
				
				if(door == null) {
					door = new Door(1259, 350, 64, 312, false, RoomNames.HALLWAY, RoomNames.MASROOM, DoorTypes.SIDE);
					door.displayName = "Door";
					door.description = "Covered in gross green slime..";
					door.interactable = true;
					doors.push(door);
				}
				
				dressingTable = new DressingTable(6, 382, 114, 405);
				objects.push(dressingTable);
				
				book = new Book(749, 444, 52, 167, new BookInfo(BookTexts.MASROOMBOOK[0], BookTexts.MASROOMBOOK[1]));
				
				window = new WindowObject(143, 20, 288, 338, WindowTypes.MASROOM);
				
				window.displayName = "Covered Window";
				window.description = "Curtains cover the view.";
				bed = new MasBed(731, 168, 273, 372);
				bed.displayName = "Ma's Bed";
				bed.description = "It's forbidden.";
				
				window.addEventListener("used", WindowUsed);
				
				cabinet1 = new MaCabinet(616, 208, 102, 181);
				
				var item:DoorKey = new DoorKey(RoomNames.CITYVIEW, ItemImages.STANDARDKEY);
				item.displayName = "Old Key";
				item.description = "A Key to the Garden Gate.";
				
				cabinet1.SetItem(item);
				item = null;
				
				cabinet2 = new MaCabinet(1015, 208, 102, 181);
				
				var staminaUpgrade:HealthUpgradeItem = new HealthUpgradeItem();
				cabinet2.SetItem(staminaUpgrade);
				staminaUpgrade = null;
				
				objects.push(cabinet1);
				objects.push(cabinet2);
				objects.push(bed);
			}
			
			door.Initialize();
			door.UseInitialize();
			bed.Initialize();
			window.Initialize();
			window.UseInitialize();
			dressingTable.Initialize();
			book.Initialize();
			book.UseInitialize();
			
			cabinet1.Initialize();
			cabinet1.UseInitialize();
			cabinet2.Initialize();
			cabinet2.UseInitialize();
			
			bLayer.addChild(door);
			bLayer.addChild(bed);
			bLayer.addChild(window);
			bLayer.addChild(cabinet1);
			bLayer.addChild(cabinet2);
			bLayer.addChild(book);

			fLayer.addChild(dressingTable);
			
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