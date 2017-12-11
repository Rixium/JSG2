package Rooms 
{
	/**
	 * ...
	 * @author Rixium
	 */
	
	import Entity.AbilityCosts;
	import Entity.EnemyBase;
	import Entity.Ma;
	import Entity.Sam;
	import Items.DoorKey;
	import Items.Item;
	import Screens.Credits;
	import Sounds.RumbleFade;
	import Sounds.Sam.SamDie;
	import fl.motion.Color;
	import flash.display.MovieClip;
	import Constants.GameManager;
	import Entity.EntityBase;
	import Objects.*;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.system.System;
	import Weapons.Weapon;
	import Chat.Chatter;
	import Constants.*;
	import Sounds.MaFight;
	import Objects.Light;
	
	import Entity.Bullet;
	import Entity.Explode;
	
	import Items.WeaponItem;
	
	public class Rooftop extends Room
	{
		var chat:Chatter;
		
		var startedMusic:Boolean = false;
		var firstChat:Boolean;
		
		var color:Color = new Color();
		var brightness:Number;
		var samRef:Sam;
		var cloudsDestroyed1:Boolean = false;
		var cloudsDestroyed2:Boolean = false;
		var ready:Boolean = false;
		var walkToEdge:Boolean = true;
		
		var channel:SoundChannel;
		var trans:SoundTransform = new SoundTransform(GameManager.soundLevel, 0);
		
		var firstTime:Boolean = true;
		var startedEndChat:Boolean = false;
		var addedEnd:Boolean = false;
		var startedFinalChat:Boolean = false;
		var ending:Boolean = false;
		var rotateSpeed:int = 1;
		var finished:Boolean = false;
		var addedItem:Boolean = false;
		var waitTimer:int = 0;
		var fading:Boolean = false;
		
		public var bossLayer:MovieClip;
		
		public function Rooftop(lastRoom:int) 
		{
			super();
			trace("At Rooftop");
			this.lastRoom = lastRoom;
			roomTrack = RoomTracks.AMBIENTHORROR;
			bossLayer = getChildByName("bossLayer") as MovieClip;
			GameManager.gameScreen.Follow(false);
		}
		
		public override function AddObjects():void {
			trace("Spawning Rooftop Objects");
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;

			if (firstVisit) {
				firstVisit = false;
				chat = new Chatter();
			}
			
			samRef = getChildByName("sam") as Sam;
			GameManager.sean.x = GameManager.main.stage.stageWidth / 2;
			GameManager.sean.y = GameManager.main.stage.stageHeight - 100;
				
			GameManager.gameScreen.Follow(false);
			
			GameManager.sean.xScale = .2;
			GameManager.sean.yScale = .2;
			
			GameManager.sean.scaleX = .2;
			GameManager.sean.scaleY = .2;
			
			GameManager.sean.GetStats().speed = 3;
			GameManager.sean.GetStats().runSpeed = 6;
			
			GameManager.ui.inventory.alpha = .2;
			
			GameManager.gameScreen.StopFollowEntity();
			GameManager.gameScreen.Follow(false);
			startedMusic = false;
			bLayer = null;
			
			fLayer = null;
			ready = true;
			bossLayer.addChild(samRef);
		}
		
		override public function Clean():void 
		{
			super.Clean();
			samRef.End();
		}
		
		public override function Update():void {
			if(ready && !samRef.dying) {
				super.Update();
				if (walkToEdge && firstTime) {
					if (GameManager.sean.y > 500) {
						
					} else {
						walkToEdge = false;
						if( GameManager.firstTimeSam) {
							chat.InitiateConversation(Conversations.rooftopConvo1);
							firstChat = true;
						}
						firstTime = false;
						if( GameManager.firstTimeSam) {
							chat.StartChat();
						}
					}
				} else if (firstChat && GameManager.firstTimeSam) {
					if (chat.GetChat() == null) {
						Shake();
						firstChat = false;
						GameManager.firstTimeSam = false;
					}
				} else {
					if (samRef.y > GameManager.main.stage.stageHeight / 2 - 200) {
						samRef.y -= 20;
						if(!cloudsDestroyed1) {
							if (cloud1.x > 0) {
								cloud1.x -= 40;
								if (cloud1.alpha > 0.1) {
									cloud1.alpha -= 0.05;
								}
							} else {
								cloud1.parent.removeChild(cloud1);
								cloudsDestroyed1 = true;
							}
						}
						if(!cloudsDestroyed2) {
							if (cloud2.x < GameManager.main.stage.stageWidth) {
								cloud2.x += 40;
								if (cloud2.alpha > 0.1) {
									cloud2.alpha -= 0.05;
								}
							} else {
								cloud2.parent.removeChild(cloud2);
								cloudsDestroyed2 = true;
							}
						}
						if (brightness > 0) {
							brightness -= 0.04;
							color.brightness = brightness;
							samRef.transform.colorTransform = color;
						}
						if(!startedMusic) {
							this.roomTrack = RoomTracks.SAMFIGHT;
							GameManager.gameScreen.musicManager.PlayTrack(roomTrack);
							startedMusic = true;
							brightness = 1;
							color.brightness = brightness;
							samRef.transform.colorTransform = color;
							GameManager.ui.SetHealthBarPos(20);
							samRef.BossReady();
						}
					} else {
						brightness = 0;
						color.brightness = brightness;
						samRef.transform.colorTransform = color;
						
						samRef.Update();
					}
				}
			} else if (samRef.dying && !startedFinalChat) {
					roomTrack = RoomTracks.MAROOMSHOCK;
					GameManager.gameScreen.musicManager.PlayTrack(roomTrack);
					GameManager.sean.Update();
					samRef.rotation++;
					if (!startedEndChat) {
						samRef.innerTentacle.visible = false;
						startedEndChat = true;
						GameManager.sean.phone.InitiateConversation(Conversations.MarkEndConvo);
					} else {
						if (GameManager.sean.phone.GetChat() == null){
							GameManager.ui.SetDescriptor("Name - [" + Keys.GetDictionary()[Keys.USE] + "]", true);
							if (!addedEnd) {
								addedEnd = true;
								GameManager.main.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
							}
						}
					}
			} else if (startedFinalChat && !ending && !finished) {
				samRef.rotation += rotateSpeed;
				if (chat.GetChat() == null) {
					chat.InitiateConversation(Conversations.endConvo2);
					chat.StartChat();
					ending = true;
					channel = new RumbleFade().play(0, 9999, trans);
				}
			} else if (ending && !finished) {
				Shake();
				samRef.rotation += rotateSpeed;
				if (chat.GetChat() == null) {
					GameManager.sean.Update();
					if (rotateSpeed < 100) {
						rotateSpeed++;
						if (rotateSpeed == 100) {
							channel.stop();
							channel = new SamDie().play(0, 0, trans);
						}
					} else {
						if (samRef.scaleX > 0.1 || samRef.scaleY > 0.1) {
							if (samRef.scaleX > 0.1) {
								samRef.scaleX -= 0.1;
							}
							if (samRef.scaleY > 0.1) {
								samRef.scaleY -= 0.1;
							}
						} else {
							
							samRef.Destroy();
							StopShake();
							finished = true;
						}
					}
					
					if (samRef.x < GameManager.main.stage.stageWidth / 2) {
						samRef.x ++;
					} else if (samRef.x > GameManager.main.stage.stageWidth / 2) {
						samRef.x --;
					}
					
					if (samRef.x < GameManager.main.stage.stageWidth / 2 + 10 &&
					samRef.x > GameManager.main.stage.stageWidth / 2 - 10) {
						samRef.x = GameManager.main.stage.stageWidth / 2;
					}
				}
			} else if (finished) {
				GameManager.sean.Update();
				if (!addedItem) {
					var item:Item = new Item(ItemImages.SAM, ItemTypes.NONE);
					item.displayName = "Sam";
					item.description = "Locked away, and safe.";
					GameManager.sean.GetInventory().AddItem(item, false);
					item = null;
					addedItem = true;
					waitTimer = 200;
				}
				if (waitTimer > 0) {
					waitTimer--;
				}
				if (addedItem && waitTimer <= 0) {
					if (!fading) {
						fading = true;
						GameManager.gameScreen.musicManager.PlayTrack(RoomTracks.NONE);
						GameManager.gameComplete = true;
						gotoAndPlay("fade");
					}
				}
			}
			
		}
		
		private function keyDown(e:KeyboardEvent) {
			if (e.keyCode == Keys.USE) {
				chat.InitiateConversation(Conversations.endConvo);
				chat.StartChat();
				startedFinalChat = true;
				GameManager.main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			}
		}
		
		private function StartEnd() {
			chat.InitiateConversation(Conversations.maDeathConvo);
			chat.StartChat();
		}
		
	}

}