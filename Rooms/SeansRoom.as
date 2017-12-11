package Rooms 
{
	/**
	 * ...
	 * @author Rixium
	 */
	
	import Objects.*;
	import Constants.*;
	import Items.*;
	import Helpers.TutorialManager;
	import Sounds.MainSound;
	import Weapons.Weapon;
	import Entity.Zombie;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.media.SoundTransform;
	import flash.media.SoundChannel;
	import Sounds.ItemPopup;
	import Entity.Smoke;
	
	public class SeansRoom extends Room
	{
		
		var studioLight:StudioLight;
		var cabinet:BedroomDrawers;
		var desk:Table;
		var shelf:Shelf;
		var door:Door;
		var rug:Rug;
		var bed:Bed;
		var computerScreen:ComputerScreen;
		var book:Book;
		var computerTower:ComputerTower;
		var plant:Plant;
		var camera:Cam;
		var television:Television;
		var keyboardObject:ComputerKeyboard;
		var mouseObject:ComputerMouse;
		var televisionStand:TelevisionStand;
		var lavaLamp:LavaLamp;
		var gamePad:GamePad
		var startedConvo:Boolean = false;
		var timer:Timer;
		var initializedUsable:Boolean = false;
		
		var tutorialManager:TutorialManager;
		
		public function SeansRoom(lastRoom:int) 
		{
			super();
			this.lastRoom = lastRoom;
			roomTrack = RoomTracks.MAIN;
		}
		
		public override function AddEnemies() {
			var zombie:Zombie = new Zombie(1100, 300, 40, 50, new Weapon(WeaponTypes.BOW, 20), ZombieHeads.BILLY);
			
			
			zombie.addEventListener("Killed", BillyDead);
			zombie.GetStats().vision = 1000;
			zombie.displayName = "Billy";
			zombie.description = "Damnit, Billy!";
			entityLayer.addChild(zombie);
			zombie = null;
		}
		
		private function BillyDead(e:Event) {
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;
			var smoke:Smoke = new Smoke(1280 / 2 - 100 , 720 / 2 + 100);
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
			var item:WeaponItem = new WeaponItem(ItemImages.BOW, WeaponTypes.BOW, 5);
			item.displayName = "Billy's Bow";
			item.description = "A child's play thing.";
			timer = new Timer(1000, 1);
			timer.addEventListener(TimerEvent.TIMER, FollowBack);
			timer.start();
			var drop:Drop = new Drop(1280 / 2 - 100, 720 / 2 + 100, item)
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
			initializedUsable = false;
			if (firstVisit) {
				firstVisit = false;
				
				lavaLamp = new LavaLamp(57, 169, 34, 95);
				gamePad = new GamePad(190, 551, 58, 49);
				objects.push(gamePad);
				
				tutorialManager = new TutorialManager();
				tutorialManager.start();
				
			}
			
			
			
			if(studioLight == null) {
				studioLight = new StudioLight(680, 88, 106, 280);
				studioLight.displayName = "Studio Light";
				studioLight.description = "A professional light for exceptional quality.";
				studioLight.interactable = true;
				objects.push(studioLight);
			}
			
			if(cabinet == null) {
				cabinet = new BedroomDrawers(20, 226, 120, 190);
				cabinet.displayName = "Cabinet";
				cabinet.description = "A place to store things.";
				cabinet.interactable = true;
				objects.push(cabinet);

				var key:DoorKey = new DoorKey(RoomNames.HALLWAY, ItemImages.STANDARDKEY);
				key.displayName = "Spare Key";
				key.description = "A copy of the key for Sean's Door.";
				cabinet.SetItem(key);
				key = null;
			}
			
			
			
			if(desk == null) {
				desk = new Table(800, 213, 439, 177);
				desk.displayName = "Desk";
				desk.description = "Not quite big enough.";
				desk.interactable = true;
				objects.push(desk);
			}
			
			if(shelf == null) {
				shelf = new Shelf(150, 64, 248, 302);
				shelf.displayName = "Shelf";
				shelf.description = "A bunch of collectibles and fan stuff.";
				shelf.interactable = true;
				objects.push(shelf);
			}
			if(door == null) {
				door = new Door(460, 61, 125, 312, true, RoomNames.HALLWAY, RoomNames.SEANSROOM, DoorTypes.SLIME);
				door.displayName = "Door";
				door.description = "Covered in gross green slime..";
				door.interactable = true;
				objects.push(door);
				doors.push(door);
			}
			
			if(rug == null) {
				rug = new Rug(320, 400, 715, 267);
				rug.displayName = "Rug";
				rug.description = "A luxurious red rug.";
				rug.collidable = false;
				objects.push(rug);
			}
			if(bed == null) {
				bed = new Bed(848, 540, 440, 220);
				bed.displayName = "Bed";
				bed.description = "A standard sized bed.";
				objects.push(bed);
			}
			if(computerScreen == null) {
				computerScreen = new ComputerScreen(971, 141, 125, 100);
				computerScreen.displayName = "Monitor";
				computerScreen.description = "There is a hole in the screen..";
				objects.push(computerScreen);
			}
			if (book == null) {
				var info:BookInfo = new BookInfo(BookTexts.SEANSROOMBOOK[0], BookTexts.SEANSROOMBOOK[1]);
				book = new Book(843, 227, 52, 166, info);
				objects.push(book);
				info = null;
			}
			
			if (computerTower == null) {
				computerTower = new ComputerTower(1151, 293, 64, 84);
				computerTower.displayName = "Tower";
				computerTower.description = "A dashing white case with plenty of space inside.";
				objects.push(computerTower);
			}
			
			if (plant == null) {
				plant = new Plant(14, 550, 190, 203);
				plant.displayName = "Plant";
				plant.description = "It's green, and leafy.";
				objects.push(plant);
			}
			
			if (camera == null) {
				camera = new Cam(1135, 141, 75, 106);
				camera.displayName = "Camera";
				camera.description = "One of the best Cameras for Youtube Video."
				objects.push(camera);
			}
			
			if (television == null) {
				television = new Television(30, 349, 57, 243);
				television.displayName = "Television";
				television.description = "Flatscreen goodness.";
				objects.push(television);
			}
			if (televisionStand == null) {
				televisionStand = new TelevisionStand(18, 408, 105, 274);
				televisionStand.displayName = "TV Stand";
				televisionStand.description = "The perfect size.";
				objects.push(televisionStand);
			}
			
			if (keyboardObject == null) {
				keyboardObject = new ComputerKeyboard(950, 210, 102, 70);
				keyboardObject.displayName = "Keyboard";
				keyboardObject.description = "It's all lit up.";
			}
			
			if (mouseObject == null) {
				mouseObject = new ComputerMouse(1074, 216, 21, 60);
				mouseObject.displayName = "Mouse";
				mouseObject.description = "Not very ergonomic.";
			}
			
			bLayer.addChild(studioLight);
			bLayer.addChild(cabinet);
			bLayer.addChild(rug);
			
			bLayer.addChild(desk);
			bLayer.addChild(shelf);
			bLayer.addChild(door);
			bLayer.addChild(camera);
			fLayer.addChild(bed);
			bLayer.addChild(book);
			bLayer.addChild(computerScreen);
			bLayer.addChild(computerTower);
			
			bLayer.addChild(keyboardObject);
			bLayer.addChild(mouseObject);
			fLayer.addChild(televisionStand);
			fLayer.addChild(television);
			fLayer.addChild(plant);
			bLayer.addChild(lavaLamp);
			bLayer.addChild(gamePad);
			
			gamePad.Initialize();
			lavaLamp.Initialize();
			studioLight.Initialize();
			
			desk.Initialize();
			shelf.Initialize();
			
			
			rug.Initialize();
			bed.Initialize();
			
			computerScreen.Initialize();
			computerTower.Initialize();
			plant.Initialize();
			camera.Initialize();
			television.Initialize();
			televisionStand.Initialize();
			mouseObject.Initialize();
			keyboardObject.Initialize();
			
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
		
		override public function Update():void 
		{
			super.Update();
			
			if(!initializedUsable) {
				if (tutorialManager.finished) {

					cabinet.Initialize();
					door.Initialize();
					book.Initialize();
					door.UseInitialize();
					book.UseInitialize();
					cabinet.UseInitialize();
					initializedUsable = true;
				}
			}
					
			if(!startedConvo) {
				if (GameManager.sean.numSteps >= 20 && tutorialManager.finished) {
					GameManager.sean.phone.InitiateConversation(Conversations.conversation1);
					startedConvo = true;
				}
			}
		}
		
	}

}