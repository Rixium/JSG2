package Rooms 
{
	/**
	 * ...
	 * @author Rixium
	 */
	
	import Objects.*;
	import Constants.RoomNames;
	import Items.WeaponItem;
	import flash.accessibility.Accessibility;
	import flash.events.Event;
	import flash.globalization.Collator;
	
	import Constants.GameManager;
	import Constants.DoorTypes;
	import Constants.Conversations;
	import Constants.ItemImages;
	import Constants.WeaponTypes;
	
	import Weapons.Weapon;
	
	public class ShedRoom extends Room
	{

		private var shedDoor:Door;
		var workBench:WorkBench;
		var crate:Crate;
		var startSteps:int;
		var scared:Boolean = false;
		
		public function ShedRoom(lastRoom:int) 
		{
			super();
			this.lastRoom = lastRoom;
			
		}
		
		private function InitiateEvent(e:Event) {
				RoomNames.GARDENINSTANCE.AddEnemies();
				RoomNames.GARDENINSTANCE.door.Lock();
				RoomNames.KITCHENINSTANCE.AddEnemies();
				RoomNames.SEANINSTANCE.AddEnemies();
				
				RoomNames.HALLINSTANCE.door.gotoAndStop(DoorTypes.SLIME);
				RoomNames.HALLINSTANCE.door.displayName = "Slimey Door";
				RoomNames.HALLINSTANCE.door.description = "It wasn't like that earlier.";
				crate.removeEventListener("itemTaken", InitiateEvent);
				startSteps = GameManager.sean.numSteps;
		}
		
		public override function AddObjects():void {
			
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;

			if(entityLayer.getChildByName("crate1") == null) {
				entityLayer.addChild(crate1);
				crate1.check();
			} else {
				crate1.Remove();
			}
			if(entityLayer.getChildByName("crate2") == null) {
				entityLayer.addChild(crate2);
				crate2.check();
			} else {
				crate2.Remove();
			}
			if(entityLayer.getChildByName("crate3") == null) {
				entityLayer.addChild(crate3);
				crate3.check();
			} else {
				crate3.Remove();
			}
			if(entityLayer.getChildByName("crate4") == null) {
				entityLayer.addChild(crate4);
				crate4.check();
			} else {
				crate4.Remove();
			}
			if(entityLayer.getChildByName("crate5") == null) {
				entityLayer.addChild(crate5);
				crate5.check();
			} else {
				crate5.Remove();
			}
			
			if (firstVisit) {
				//GameManager.sean.phone.InitiateConversation(Conversations.conversation2);
				firstVisit = false;

				shedDoor = new Door(380, 65, 125, 312, false, RoomNames.GARDEN, RoomNames.SHED, DoorTypes.SHEDDOOR);
				shedDoor.displayName = "Passage";
				shedDoor.description = "An entrance to the garden.";
				shedDoor.interactable = true;
				doors.push(shedDoor);
				
				var item:WeaponItem = new WeaponItem(ItemImages.STICK, WeaponTypes.STICK, 5);
				item.displayName = "Stick";
				item.description = "A stick with a hook."
				
				workBench = new WorkBench(521, 246, 311, 175);
				objects.push(workBench);
				
				crate = new Crate(884, 244, 112, 235);
				crate.displayName = "Crate";
				crate.description = "Full of bits and bobs.";
				objects.push(crate);
				
				crate.SetItem(item);
				crate.addEventListener("itemTaken", InitiateEvent);
				
				item = null;
			}

			shedDoor.Initialize();
			shedDoor.UseInitialize();

			crate.Initialize();
			crate.UseInitialize();
			
			workBench.Initialize();
			
			bLayer.addChild(crate);
			bLayer.addChild(shedDoor);
			bLayer.addChild(workBench);
			
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
			
			GameManager.gameScreen.Follow(false);
			//scaleX = .5;
			//scaleY = .5;
			
			bLayer = null;
			fLayer = null;
			
		}
		
		override public function Update():void 
		{
			super.Update();
			
			if (!scared) {
				if(startSteps != 0) {
					if (GameManager.sean.numSteps >= startSteps + 10) {
						window.gotoAndPlay("animate");
						scared = true;
					}
				}
			}
		}
	}

}