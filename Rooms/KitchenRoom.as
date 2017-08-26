package Rooms 
{
	/**
	 * ...
	 * @author Rixium
	 */
	
	import Objects.*;
	import Constants.RoomNames;
	import Items.DoorKey;
	import Items.WeaponItem;
	import Constants.ItemImages;
	
	import Constants.GameManager;
	import Constants.DoorTypes;
	import Constants.WindowTypes;
	import Constants.WeaponTypes;
	
	public class KitchenRoom extends Room
	{
		
		var door:Door;
		var door2:Door;
		var fridge:Fridge;
		var drawers:KitchenDrawers;
		var counter:KitchenCounter;
		var counter2:HalfKitchenCounter;
		var sink:KitchenCounterSink;
		var cooker:KitchenCooker;
		var window:WindowObject;

		public function KitchenRoom(lastRoom:int) 
		{
			super();
			this.lastRoom = lastRoom;
		}
		
		public override function AddObjects():void {
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;
			
			
			
			if(door == null) {
				door = new Door(1259, 350, 64, 312, false, RoomNames.LIVINGROOM, RoomNames.KITCHEN, DoorTypes.SIDE);
				door.displayName = "Door";
				door.description = "Goes through to the Living Room.";
				door.interactable = true;
				doors.push(door);
			}
			
			if (door2 == null) {
				door2 = new Door(24, 61, 144, 312, false, RoomNames.GARDEN, RoomNames.KITCHEN, DoorTypes.CLEAN);
				door2.displayName = "Door";
				door2.description = "Door to the garden.";
				door2.interactable = true;
				doors.push(door2);
			}
			
			if (firstVisit) {
				fridge = new Fridge(1084, 105, 118, 289);
				fridge.displayName = "Fridge";
				fridge.description = "Mmmm, food.";
				
				counter = new KitchenCounter(619, 226, 310, 168);
				counter.displayName = "Counter";
				counter.description = "For easy food preparation.";
				
				counter2 = new HalfKitchenCounter(183, 226, 155, 168);
				counter2.displayName = "Counter";
				counter2.description = "For easy food preparation.";
				
				sink = new KitchenCounterSink(929,221, 155, 173);
				sink.displayName = "Sink";
				sink.description = "What's a kitchen without a sink?";
				
				cooker = new KitchenCooker(491, 226, 128, 168);
				cooker.displayName = "Cooker";
				cooker.description = "The timer is broken.";
				
				var weap:WeaponItem = new WeaponItem(ItemImages.BUTCHERSKNIFE, WeaponTypes.BUTCHERSKNIFE, 5);
				weap.displayName = "Butcher's Knife";
				weap.description = "Sharp, but short.";
				
				drawers = new KitchenDrawers(338, 226, 155, 218);
				drawers.displayName = "Kitchen Drawers";
				drawers.description = "A place to store cutlery.";
				drawers.SetItem(weap);
				
				window = new WindowObject(497, 45, 308, 154, WindowTypes.KITCHEN);
				window.displayName = "Window";
				window.description = "I can see the back garden through it.";
				
				objects.push(fridge);
				objects.push(counter);
				objects.push(counter2);
				objects.push(sink);
				objects.push(cooker);
				objects.push(drawers);
			
				firstVisit = false;
			}

			fridge.Initialize();
			counter.Initialize();
			counter2.Initialize();
			sink.Initialize();
			cooker.Initialize();
			drawers.Initialize();
			drawers.UseInitialize();

			door.Initialize();
			door.UseInitialize();
			
			door2.Initialize();
			door2.UseInitialize();
			
			window.Initialize();
			
			bLayer.addChild(door);
			bLayer.addChild(fridge);
			bLayer.addChild(counter);
			bLayer.addChild(counter2);
			bLayer.addChild(sink);
			bLayer.addChild(drawers);
			bLayer.addChild(cooker);
			bLayer.addChild(window);
			bLayer.addChild(door2);
			

			if (lastRoom != RoomNames.NONE) {
				for (var i:int = 0; i < doors.length; i++) {
					var d:Door = doors[i];
					
					if (d.roomLink == lastRoom) {
						if(d.doorType != DoorTypes.SIDE) {
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