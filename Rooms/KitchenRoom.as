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
	import Items.Item;
	import Items.WeaponItem;
	import Constants.ItemImages;
	import Weapons.Weapon;
	
	import Constants.GameManager;
	import Constants.DoorTypes;
	import Constants.WindowTypes;
	import Constants.WeaponTypes;
	import Constants.ZombieHeads;
	import Entity.Zombie;
	
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
		var kettle:Kettle;
		var pans:KitchenPans;
		var knifeBlock:KnifeBlock;

		public function KitchenRoom(lastRoom:int) 
		{
			super();
			this.lastRoom = lastRoom;
		}
		
		public override function AddEnemies() {
			var zombie:Zombie = new Zombie(1123, 345, 40, 50, new Weapon(WeaponTypes.SPADE, 10), ZombieHeads.HEAD2);
			entityLayer.addChild(zombie);
			
			var zombie2:Zombie = new Zombie(747, 400, 40, 50, new Weapon(WeaponTypes.BUTCHERSKNIFE, 10), ZombieHeads.HEAD3);
			entityLayer.addChild(zombie2);
			
			zombie = null;
			zombie2 = null;
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
				fridge = new Fridge(1084, 105, 118, 304);
				fridge.displayName = "Fridge";
				fridge.description = "Mmmm, food.";
				
				counter = new KitchenCounter(619, 226, 310, 168);
				counter.displayName = "Counter";
				counter.description = "For easy food preparation.";
				
				counter2 = new HalfKitchenCounter(184, 226, 155, 168);
				counter2.displayName = "Counter";
				counter2.description = "For easy food preparation.";
				
				sink = new KitchenCounterSink(929,221, 155, 173);
				sink.displayName = "Sink";
				sink.description = "What's a kitchen without a sink?";
				
				cooker = new KitchenCooker(493, 226, 128, 168);
				cooker.displayName = "Cooker";
				cooker.description = "The timer is broken.";
				
				var health:HealthUpgradeItem = new HealthUpgradeItem();
				
				drawers = new KitchenDrawers(339, 226, 155, 218);
				drawers.displayName = "Kitchen Drawers";
				drawers.description = "A place to store cutlery.";
				drawers.SetItem(health);
				
				window = new WindowObject(497, 45, 308, 154, WindowTypes.KITCHEN);
				window.displayName = "Window";
				window.description = "I can see the back garden through it.";
				
				kettle = new Kettle(799, 194, 112, 59);
				kettle.displayName = "Kettle";
				kettle.description = "Tasty coffee.";
				
				pans = new KitchenPans(272, 38, 163, 99);
				pans.displayName = "Pans";
				pans.description = "Made for frying food.";
				
				knifeBlock = new KnifeBlock(218, 175, 46, 73);
				
				objects.push(fridge);
				objects.push(counter);
				objects.push(counter2);
				objects.push(sink);
				objects.push(cooker);
				objects.push(drawers);
			
				firstVisit = false;
			}

			fridge.Initialize();
			fridge.UseInitialize();
			counter.Initialize();
			counter2.Initialize();
			sink.Initialize();
			cooker.Initialize();
			drawers.Initialize();
			drawers.UseInitialize();
			kettle.Initialize();
			door.Initialize();
			door.UseInitialize();
			
			knifeBlock.Initialize();
			
			pans.Initialize();
			
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
			bLayer.addChild(kettle);
			bLayer.addChild(pans);
			bLayer.addChild(knifeBlock);

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