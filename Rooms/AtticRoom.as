package Rooms 
{
	/**
	 * ...
	 * @author Rixium
	 */
	
	import Entity.AbilityCosts;
	import Entity.EnemyBase;
	import Entity.Ma;
	import Items.DoorKey;
	import Items.Item;
	import flash.display.MovieClip;
	import Constants.GameManager;
	import Entity.EntityBase;
	import Objects.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.System;
	import Weapons.Weapon;
	import Chat.Chatter;
	import Constants.*;
	import Sounds.MaFight;
	import Objects.Light;
	
	import Entity.Bullet;
	import Entity.Explode;
	
	public class AtticRoom extends Room
	{
		var chat:Chatter;
		
		var startedMusic:Boolean = false;
		
		var maRef:Ma;
		var ended:Boolean = false;
		var finished:Boolean = false;
		var shownAll:Boolean = false;
		var complete:Boolean = false;
		
		var hatchDoor:Door;
		var lightSize:int = 1400;
		
		public function AtticRoom(lastRoom:int) 
		{
			super();
			StopShake();
			this.lastRoom = lastRoom;
			roomTrack = RoomTracks.NONE;
		}
		
		public override function AddObjects():void {
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;

			entityLayer.addChild(crate1);
			entityLayer.addChild(crate2);
			entityLayer.addChild(crate3);
			entityLayer.addChild(crate4);
			entityLayer.addChild(crate5);
			
			if (firstVisit || !GameManager.maKilled) {
				firstVisit = false;
				hatchDoor = new Door(GameManager.main.stage.stageWidth / 2 - 64, GameManager.main.stage.stageHeight / 2 - 64, 128, 128, true, RoomNames.HALLWAY, RoomNames.ATTIC, DoorTypes.HATCHTOP);
				hatchDoor.displayName = "Hatch";
				hatchDoor.description = "A hatch down to the hall.";
				hatchDoor.useText = "Descend";
				doors.push(hatchDoor);
				
				
			
				chat = new Chatter();
				
				if(!GameManager.visitedMa) {
					chat.InitiateConversation(Conversations.atticConvo);
					chat.StartChat();
					GameManager.visitedMa = true;
				}
				maRef = new Ma(282, 472, 212, 399);
				fLayer.addChild(maRef);
				
				var light:Light = new Light(GameManager.main.stage.stageWidth / 2 - lightSize / 2, GameManager.main.stage.stageHeight / 2 - lightSize / 2, lightSize, lightSize);
				lightMask.addChild(light);
				light = null;
			}

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
			
			startedMusic = false;
			bLayer.addChild(hatchDoor);
			hatchDoor.Initialize();
			hatchDoor.UseInitialize();
			
			basementBorder.mouseEnabled = false;
			bLayer = null;
			fLayer = null;
		}
		
		public override function Update():void {
			if (canUpdate) {
				if(eLayer.numChildren > 1) {
					for (var i:int = 0; i < eLayer.numChildren; i++) {
						if (i + 1 < eLayer.numChildren) {
							var e1:EntityBase = (eLayer.getChildAt(i) as EntityBase);
							var e2:EntityBase = eLayer.getChildAt(i + 1) as EntityBase;
							var rect1:Rectangle = e1.eBounds.getBounds(stage);
							var rect2:Rectangle = e2.eBounds.getBounds(stage);
							if (rect1.y + rect1.height > rect2.y + rect2.height) {
								eLayer.swapChildrenAt(i, i + 1);
							}
							rect1 = null;
							rect2 = null;
							e1 = null;
							e2 = null;
						}
					}
				}
				for (var z:int = 0; z < eLayer.numChildren; z++) {
					if(eLayer.getChildAt(z) != null) {
						var e:EntityBase = (eLayer.getChildAt(z)) as EntityBase;
						if(e != null) {
							e.Update();
						}
					}
				}
				
				for (var y:int = 0; y < bullets.length; y++) {
					var bullet:Bullet = bullets[y] as Bullet;
					bullet.Update();
					if (BulletAttack(bullet.GetOwner(), bullet, bullet.GetDamage(), bullet.GetKnockback())) {
						bullet.SetDead();
						var explode:Explode = new Explode(bullet.getBounds(stage).x, bullet.getBounds(stage).y);
						var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;
						fLayer.addChild(explode);
						fLayer = null;
						explode = null;
					}
					if (bullet.GetDead()) {
						bullets.removeAt(y);
						bullet.Kill();
						break;
					}
					
					bullet = null;
				}
				
				if (chat.GetChat() == null) {
					if (!startedMusic && !complete) {
						startedMusic = true;
						roomTrack = RoomTracks.MAFIGHT;
						GameManager.gameScreen.musicManager.PlayTrack(roomTrack);
						maRef.Initialize();
						maRef.body.headHolder.head.gotoAndStop("angry");
						maRef.ReadyUp();
						GameManager.ui.SetHealthBarPos(20);
					}
					if (ended && !finished) {
						GameManager.maKilled = true;
						StopShake();
						GameManager.sean.immune = true;
						finished = true;
						maRef.body.gotoAndStop("idle");
						maRef.legs.gotoAndStop("idle");
						maRef.gotoAndPlay("dying");
						maRef.body.headHolder.head.gotoAndStop("happy");
					} else if (ended && finished && !shownAll) {
						if (maRef.currentLabel == "dead") {
							maRef.Remove();
							chat.InitiateConversation(Conversations.maDeadConvo);
							chat.StartChat();
							shownAll = true;
						}
					} else if (shownAll && !complete) {
						var maKey:DoorKey = new DoorKey(RoomNames.MASROOM, ItemImages.MASKEY);
							maKey.displayName = "Ma's Key";
							maKey.description = "A key to Ma's room.";
							GameManager.sean.GetInventory().AddItem(maKey, false);
							GameManager.sean.immune = false;
							maKey = null;
							complete = true;
							hatchDoor.Unlock();
							GameManager.sean.immune = false;
					}
				}
				
				if (shaking) {
					Shake();
				}
				
				if(maRef != null) {
					if (maRef.dead && !ended) {
						StartEnd();
						GameManager.sean.immune = true;
						maRef.immune = true;
						ended = true;
						GameManager.gameScreen.musicManager.PlayTrack(RoomTracks.NONE);
					}
					if (maRef.dead && !complete) {
						GameManager.sean.immune = true;
					}
				}
			}
		}
		
		private function StartEnd() {
			chat.InitiateConversation(Conversations.maDeathConvo);
			chat.StartChat();
		}
		
	}

}