package Rooms 
{
	/**
	 * ...
	 * @author Rixium
	 */
	
	import Objects.*;
	import Constants.*;
	import Items.*;
	import Chat.Chatter;
	import Entity.Bin;
	import Sounds.MainSound;
	import Weapons.Weapon;
	import Entity.Zombie;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import Sounds.CarHorn;
	import Sounds.CarEngine;
	import Sounds.CarScreech;
	import flash.utils.Timer;
	import Entity.Smoke;
	import Sounds.ItemPopup;
	
	public class CityRoom extends Room
	{
		
		var car:MarkiplierCar;
		var trans:SoundTransform;
		var startLevel:Boolean = true;
		var hornPlayed:Boolean = false;
		var engineStarted:Boolean = false;
		var screechStarted:Boolean = false;
		var carSpeed:int = 20;
		var chatter:Chatter = new Chatter();
		var startedChat1:Boolean = false;
		var startedChat2:Boolean = false;
		
		var bin:Bin;
		var bin1:Bin;
		var bin2:Bin;
		var bin3:Bin;
		
		var door:Door;
		var channel:SoundChannel;
		
		var deadEnemies:int;
		var spawnedPowerups:Boolean = false;
		var timer:Timer;
		
		public function CityRoom(lastRoom:int) 
		{
			super();
			this.lastRoom = lastRoom;
			roomTrack = RoomTracks.MAIN;
			GameManager.gameScreen.Follow(false);
		}
		
		public override function AddEnemies() {
			var zombie:Zombie = new Zombie(1990, 410, 40, 50, new Weapon(WeaponTypes.BUTCHERSKNIFE, 10), ZombieHeads.RANDOM);
			eLayer.addChild(zombie);
			
			var zombie1:Zombie = new Zombie(2076, 900, 40, 50, new Weapon(WeaponTypes.RAKE, 10), ZombieHeads.RANDOM);
			eLayer.addChild(zombie1);
			
			var zombie2:Zombie = new Zombie(2617, 73, 40, 50, new Weapon(WeaponTypes.SPADE, 10), ZombieHeads.RANDOM);
			eLayer.addChild(zombie2);
			
			var zombie3:Zombie = new Zombie(3609, 18, 40, 50, new Weapon(WeaponTypes.BUTCHERSKNIFE, 10), ZombieHeads.RANDOM);
			eLayer.addChild(zombie3);
			
			var zombie4:Zombie = new Zombie(2940, 615, 40, 50, new Weapon(WeaponTypes.BOW, 10), ZombieHeads.RANDOM);
			eLayer.addChild(zombie4);
			zombie4.GetStats().vision = 1000;
			
			var zombie5:Zombie = new Zombie(4358, 171, 40, 50, new Weapon(WeaponTypes.BOW, 10), ZombieHeads.RANDOM);
			eLayer.addChild(zombie5);
			zombie5.GetStats().vision = 1000;
			
			var zombie6:Zombie = new Zombie(4525, 900, 40, 50, new Weapon(WeaponTypes.BOW, 10), ZombieHeads.RANDOM);
			eLayer.addChild(zombie6);
			zombie6.GetStats().vision = 1000;
			
			var zombie7:Zombie = new Zombie(3802, 677, 40, 50, new Weapon(WeaponTypes.BUTCHERSKNIFE, 10), ZombieHeads.RANDOM);
			eLayer.addChild(zombie7);
			
			zombie.addEventListener("dead", AddDead);
			zombie1.addEventListener("dead", AddDead);
			zombie2.addEventListener("dead", AddDead);
			zombie3.addEventListener("dead", AddDead);
			zombie4.addEventListener("dead", AddDead);
			zombie5.addEventListener("dead", AddDead);
			zombie6.addEventListener("dead", AddDead);
			zombie7.addEventListener("dead", AddDead);
			
			zombie = null;
			zombie1 = null;
			zombie2 = null;
			zombie3 = null;
			zombie4 = null;
			zombie5 = null;
			zombie6 = null;
			zombie7 = null;
		}
		
		public function AddDead(e:Event) {
			deadEnemies++;
		}
		public override function AddObjects():void {
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;
			
			if (firstVisit) {
				//GameManager.sean.phone.InitiateConversation(Conversations.conversation1);
				firstVisit = false;
				door = new Door(4534, -328, 144, 312, false, RoomNames.ROOFTOP, RoomNames.CITY, DoorTypes.SHEDDOOR);
				door.displayName = "Passage";
				door.description = "A  passage up to the rooftop.";
				doors.push(door);
				
				bin = new Bin(810, 43);
				bin1 = new Bin(2131, 43);
				bin2 = new Bin(3253, 43);
				bin3 = new Bin(4201, 43);
				eLayer.addChild(bin);
				eLayer.addChild(bin1);
				eLayer.addChild(bin2);
				eLayer.addChild(bin3);
				GameManager.sean.ready = false;
			}
			
			bin.Initialize();
			bin1.Initialize();
			bin2.Initialize();
			bin3.Initialize();

			door.Initialize();
			door.UseInitialize();
			
			bLayer.addChild(door);
			
			car = markiplierCar;
			car.seanHead.visible = true;
			bLayer = null;
			fLayer = null;
			
			trans = new SoundTransform(GameManager.soundLevel, 0);
			eLayer.addChild(GameManager.sean);
		}
		
		private function FollowSean(e:Event) {
			var trans:SoundTransform = new SoundTransform(GameManager.soundLevel, 0);
			var channel:SoundChannel = new ItemPopup().play(0, 0, trans);
			trans = null;
			channel = null;
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			timer = new Timer(1000, 1);
			timer.addEventListener(TimerEvent.TIMER, FollowBack);
			timer.start();
			var drop:Drop = new Drop(3741, 35, new HealthUpgradeItem())
			var drop2:Drop = new Drop(3890, 35, new StaminaUpgradeItem())
			GameManager.gameScreen.GetRoom().AddDrop(drop);
			GameManager.gameScreen.GetRoom().AddDrop(drop2);
			drop.Initialize();
			drop.UseInitialize();
			drop2.Initialize();
			drop2.UseInitialize();
			drop = null;
			drop2 = null;
		}
		
		private function FollowBack(e:TimerEvent) {
			timer.removeEventListener(TimerEvent.TIMER, FollowBack);
			timer = null;
			GameManager.gameScreen.FollowEntity(GameManager.sean);
		}
		
		override public function Update():void 
		{
			super.Update();
			
			if (!spawnedPowerups) {
				if (deadEnemies == 8) {
					var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;
					var smoke:Smoke = new Smoke(3741, 35);
					var smoke2:Smoke = new Smoke(3890, 35);
					fLayer.addChild(smoke);
					fLayer.addChild(smoke2);
					GameManager.gameScreen.FollowEntity(smoke);
					smoke.addEventListener("Finished", FollowSean);
					smoke = null;
					spawnedPowerups = true;
				}
			}
			
			if (startLevel) {
				GameManager.sean.ready = false;
				if (car.x < 0 + car.width / 2 + 100) {
					car.x += carSpeed;
				} else {
					startLevel = false;
					chatter.InitiateConversation(Conversations.cityStartConvo);
					chatter.StartChat();
					startedChat1 = true;
				}
				if (car.x > 0 - car.width / 2) {
					GameManager.gameScreen.FollowEntity(car);
					
				}
				if (car.x > 0 + car.width / 2) {
						if (!hornPlayed) {
							channel = new CarHorn().play(0, 0, trans);
							channel = null;
							hornPlayed = true;
						}
						if(carSpeed > 2) {
							carSpeed--;
						}
				}
			} else if (startedChat1) {
				GameManager.sean.ready = false;
				if (chatter.GetChat() == null) {
					var weaponItem:WeaponItem = new WeaponItem(ItemImages.SHOTGUN, WeaponTypes.SHOTGUN, 7);
					weaponItem.displayName = "Mark's Shotgun";
					weaponItem.description = "A powerful weapon.";
					GameManager.sean.GetInventory().AddItem(weaponItem, false);
					startedChat1 = false;
					chatter.InitiateConversation(Conversations.cityStartConvo2);
					chatter.StartChat();
					startedChat2 = true;
				}
			} else if (startedChat2) {
				GameManager.sean.ready = false;
				if (chatter.GetChat() == null) {
					car.seanHead.visible = false;
					GameManager.gameScreen.StopFollowEntity();
					GameManager.gameScreen.Follow(true);
					GameManager.sean.x = 200;
					GameManager.sean.y = 450;
					GameManager.sean.visible = true;
					if (car.x < GameManager.main.stage.stageWidth + car.width * 2) {
						car.x += carSpeed;
					} else {
						startedChat2 = false;
						car.Kill();
						GameManager.sean.ready = true;
					}
					if (car.x > 0 + car.width * 1.4) {
						carSpeed++;
						if (!screechStarted) {
							channel = new CarScreech().play(0, 0, trans);
							channel = null;
							screechStarted = true;
							AddEnemies();
						}
					} 
				}
			}
		}
		
	}

}