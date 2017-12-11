package Rooms 
{
	/**
	 * ...
	 * @author Rixium
	 */
	
	import Objects.*;
	import Constants.RoomNames;
	import Items.DoorKey;
	
	import Constants.GameManager;
	import Constants.DoorTypes;
	import Constants.BookTexts;
	import Constants.RoomTracks;
	import Constants.ItemImages;
	
	public class LivingRoom extends Room
	{
		
		var door:Door;
		var door2:Door;
		var door3:Door;
		var sofa:Sofa;
		var coffeeTable:CoffeeTable;
		var dinnerTable:DinnerTable;
		var livingRoomArt:Art;
		var fishtank:Fishtank;
		var keyHolder:KeyHolder;
		
		var book:Book;

		public function LivingRoom(lastRoom:int) 
		{
			super();
			this.lastRoom = lastRoom;
			roomTrack = RoomTracks.MAIN;
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
				
				keyHolder = new KeyHolder(1020, 230, 54, 200);
				keyHolder.displayName = "Key Holder";
				keyHolder.description = "A key hangs from it.";
				var key:DoorKey = new DoorKey(RoomNames.BASEMENT, ItemImages.STANDARDKEY);
				key.displayName = "Basement Key";
				key.description = "I'm not too key'n to use this.";
				keyHolder.SetItem(key);
				key = null;
				
				fishtank = new Fishtank(70, 584, 272, 213);
				fishtank.displayName = "Fishtank";
				fishtank.description = "A single goldfish is swimming around.";
				objects.push(fishtank);
				
				coffeeTable = new CoffeeTable(223, 392, 364, 139);
				coffeeTable.displayName = "Coffee Table";
				coffeeTable.description = "Made for feet.";
				objects.push(coffeeTable);
				
				book = new Book(264, 420, 52, 167, new BookInfo(BookTexts.LIVINGROOMBOOK[0], BookTexts.LIVINGROOMBOOK[1]));
				
				dinnerTable = new DinnerTable(692, 541, 525, 347);
				dinnerTable.displayName = "Dinner Table";
				dinnerTable.description = "Somewhere for the whole family to eat.";
				objects.push(dinnerTable);
				
				livingRoomArt = new Art(348, 49, 122, 122, 2);
				
				livingRoomArt.displayName = "Photo";
				livingRoomArt.description = "A picture of Sean and Ma in the garden.";
			}
			
			sofa.Initialize();
			coffeeTable.Initialize();
			book.Initialize();
			book.UseInitialize();
			dinnerTable.Initialize();
			livingRoomArt.Initialize();
			keyHolder.Initialize();
			keyHolder.UseInitialize();
			
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
				door3 = new Door(1120, door2.y + door2.height - 263, 125, 312, true, RoomNames.BASEMENT, RoomNames.LIVINGROOM, DoorTypes.CLEAN);
				door3.displayName = "Door";
				door3.description = "A door to the basement.";
				door3.interactable = true;
				doors.push(door3);
			}
			
			door3.Initialize();
			door3.UseInitialize();
			
			fishtank.Initialize();
			
			bLayer.addChild(door);
			bLayer.addChild(door2);
			bLayer.addChild(door3);
			bLayer.addChild(sofa);
			bLayer.addChild(coffeeTable);
			bLayer.addChild(book);
			fLayer.addChild(dinnerTable);
			bLayer.addChild(livingRoomArt);
			fLayer.addChild(fishtank);
			bLayer.addChild(keyHolder);

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