package Rooms 
{
	/**
	 * ...
	 * @author Rixium
	 */
	
	import Objects.*;
	import Constants.RoomNames;
	import Entity.Smoke;
	import Entity.Zombie;
	import Items.DoorKey;
	import Items.Drop;
	import Items.StaminaUpgradeItem;
	import Weapons.Weapon;
	import flash.accessibility.Accessibility;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.globalization.Collator;
	import flash.utils.Timer;
	
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import Sounds.ItemPopup;
	
	import Constants.GameManager;
	import Constants.DoorTypes;
	import Constants.Conversations;
	import Constants.WeaponTypes;
	import Constants.ItemImages;
	import Constants.ZombieHeads;
	
	public class GardenRoom extends Room
	{
		
		public var door:Door;
		private var house:House;
		private var shed:Shed;
		private var shedDoor:Door;
		var crate:Crate;
		var gate:Door;
		var lightSize:int = 4000;
		var timer:Timer;
		
		public function GardenRoom(lastRoom:int) 
		{
			super();
			this.lastRoom = lastRoom;
		}
		
		public override function AddEnemies() {
			var zombie:Zombie = new Zombie(700, 800, 40, 50, new Weapon(WeaponTypes.RAKE, 10), ZombieHeads.HEAD1);
			
			
			gate.SetConfirm();

			entityLayer.addChild(zombie);
			zombie.addEventListener("Killed", SpawnKey);
			zombie = null;
		}
		
		private function SpawnKey(e:Event) {
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;
			var smoke:Smoke = new Smoke(1000, 750);
			fLayer.addChild(smoke);
			GameManager.gameScreen.FollowEntity(smoke);
			smoke.addEventListener("Finished", FollowSean);
			smoke = null;
		}
		
		private function FollowSean(e:Event) {
			var trans:SoundTransform = new SoundTransform(GameManager.soundLevel, 0);
			var channel:SoundChannel = new ItemPopup().play(0, 0, trans);
			trans = null;
			channel = null;
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var item:DoorKey = new DoorKey(RoomNames.KITCHEN, ItemImages.STANDARDKEY);
			item.displayName = "House Key";
			item.description = "A key to the back door.";
			timer = new Timer(1000, 1);
			timer.addEventListener(TimerEvent.TIMER, FollowBack);
			timer.start();
			var drop:Drop = new Drop(1000, 750, item)
			GameManager.gameScreen.GetRoom().AddDrop(drop);
			drop.Initialize();
			drop.UseInitialize();
			drop = null;
			item = null;
		}
		
		private function FollowBack(e:TimerEvent) {
			timer.removeEventListener(TimerEvent.TIMER, FollowBack)
			timer = null;
			GameManager.gameScreen.FollowEntity(GameManager.sean);
		}
		
		public override function AddObjects():void {
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;

			border.mouseEnabled = false;

			if(entityLayer.getChildByName("crate1") == null) {
				entityLayer.addChild(crate1);
				crate1.check();
			} else {
				crate1.Remove();
			}
			
			if (firstVisit) {
				//GameManager.sean.phone.InitiateConversation(Conversations.conversation2);
				firstVisit = false;
				house = new House(1416, 105, 1289, 1178);
				house.displayName = "House";
				house.description = "Home, Sweet home.";
				objects.push(house);
				
				shed = new Shed(265, -11, 440, 552);
				shed.displayName = "Shed";
				shed.description = "An outhouse full of tools.";
				objects.push(shed);
				
				shedDoor = new Door(512, 305, 129, 280, false, RoomNames.SHED, RoomNames.GARDEN, DoorTypes.SHEDDOOR);
				shedDoor.displayName = "Passage";
				shedDoor.description = "An entrance in to the dark shed.";
				shedDoor.interactable = true;
				doors.push(shedDoor);
				
				gate = new Door(1102, 120, 158, 292, true, RoomNames.CITYVIEW, RoomNames.GARDEN, DoorTypes.GARDENGATE);
				gate.SetConfirm();
				gate.displayName = "Gate";
				gate.description = "To the city.";
				gate.interactable = true;
				doors.push(gate);
				
				var item:StaminaUpgradeItem = new StaminaUpgradeItem();
				
				crate = new Crate(419, 1007, 112, 235);
				crate.displayName = "Crate";
				crate.description = "Full of bits and bobs.";
				crate.interactable = false;
				objects.push(crate);
				
				crate.SetItem(item);
				item = null;
			}
			
			if(door == null) {
				door = new Door(1795, 1073, 125, 249, false, RoomNames.KITCHEN, RoomNames.GARDEN, DoorTypes.CLEAN);
				door.displayName = "Door";
				door.description = "A door leading to the Kitchen.";
				door.interactable = true;
				doors.push(door);
				
			}
			
			door.Initialize();
			door.UseInitialize();
			shedDoor.Initialize();
			shedDoor.UseInitialize();
			gate.Initialize();
			gate.UseInitialize();
			house.Initialize();
			shed.Initialize();

			crate.Initialize();
			crate.UseInitialize();
			
			bLayer.addChild(crate);
			
			bLayer.addChild(shed);
			bLayer.addChild(house);
			bLayer.addChild(door);
			bLayer.addChild(shedDoor);
			bLayer.addChild(gate);

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
						}
					}
					
					
						
					 d = null;
				}
			}
			
			GameManager.gameScreen.Follow(true);
			//scaleX = .5;
			//scaleY = .5;
			
			bLayer = null;
			fLayer = null;
			
		}
		
	}

}