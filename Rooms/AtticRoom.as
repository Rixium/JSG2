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
	
	public class AtticRoom extends Room
	{

		
		var chat:Chatter;
		
		var startedMusic:Boolean = false;
		
		var maRef:Ma;
		var ended:Boolean = false;
		var finished:Boolean = false;
		var shownAll:Boolean = false;
		var complete:Boolean = false;
		
		public function AtticRoom(lastRoom:int) 
		{
			super();
			this.lastRoom = lastRoom;
		}
		
		public override function AddObjects():void {
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;

			if (firstVisit) {
				firstVisit = false;
				GameManager.gameScreen.StopTrack();
				chat = new Chatter();
				chat.InitiateConversation(Conversations.atticConvo);
				chat.StartChat();
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
			
			
			basementBorder.mouseEnabled = false;
			bLayer = null;
			fLayer = null;
		}
		
		public override function Update():void {
			if(canUpdate) {
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
				
				if (chat.GetChat() == null) {
					if (!startedMusic) {
						startedMusic = true;
						GameManager.gameScreen.PlayTrack(new MaFight(), true);
						maRef = ma;
						maRef.Initialize();
						maRef.body.headHolder.head.gotoAndStop("angry");
					}
					if (ended && !finished) {
						StopShake();
						finished = true;
						maRef.body.gotoAndStop("idle");
						maRef.legs.gotoAndStop("idle");
						maRef.gotoAndPlay("dying");
						maRef.body.headHolder.head.gotoAndStop("happy");
					} else if (ended && finished && !shownAll) {
						if (maRef.currentLabel == "dead") {
							maRef.parent.removeChild(maRef);
							chat.InitiateConversation(Conversations.maDeadConvo);
							chat.StartChat();
							shownAll = true;
						}
					} else if (shownAll && !complete) {
						var maKey:DoorKey = new DoorKey(RoomNames.MASROOM, ItemImages.MASKEY);
							maKey.displayName = "Ma's Key";
							maKey.description = "A key to Ma's room.";
							GameManager.sean.GetInventory().AddItem(maKey, false);
							maKey = null;
							complete = true;
					}
				}
				
				if (shaking) {
					Shake();
				}
				
				if(maRef != null) {
					if (maRef.dead && !ended) {
						StartEnd();
						ended = true;
					}
				}
			}
		}
		
		private function StartEnd() {
			GameManager.gameScreen.StopTrack();
			chat.InitiateConversation(Conversations.maDeathConvo);
			chat.StartChat();
		}
		
	}

}