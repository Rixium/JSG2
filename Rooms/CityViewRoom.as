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
	import Sounds.MainSound;
	import Weapons.Weapon;
	import Entity.Zombie;
	import flash.events.Event;
	import Sounds.CarEngine;
	import Sounds.CarScreech;
	import Sounds.CarHorn;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	
	public class CityViewRoom extends Room
	{
		
		var chat:Chatter;
		var car:MarkiplierCar;
		var startedChat:Boolean;
		var driveBy:Boolean;
		var driveAway:Boolean = false;
		var carSpeed:int = 20;
		var carSoundStarted:Boolean = false;
		var hornPlayed:Boolean = false;
		var screechPlayed:Boolean = false;
		var transform2:SoundTransform;
		var transform3:SoundTransform;
		var carEngine:CarEngine;
		var c1:SoundChannel;
		var c2:SoundChannel;
		var c3:SoundChannel;
		
		public function CityViewRoom(lastRoom:int) 
		{
			super();
			this.lastRoom = lastRoom;
			roomTrack = RoomTracks.MAROOMSHOCK;
			GameManager.gameScreen.Follow(false);
		}
		
		
		public override function AddObjects():void {
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;
			
			if (firstVisit) {
				//GameManager.sean.phone.InitiateConversation(Conversations.conversation1);
				firstVisit = false;
			}
			
			GameManager.sean.x = GameManager.sean.width + 100;
			GameManager.sean.y = GameManager.main.stage.stageHeight - GameManager.sean.height;
			bLayer = null;
			fLayer = null;
			
			car = markiplierCar;
			driveBy = true;
			startedChat = false;
			chat = new Chatter();
			car.addEventListener("Used", GetInCar);
			car.usable = false;
			transform2 = new SoundTransform(GameManager.soundLevel, 0);
			transform3 = new SoundTransform(GameManager.soundLevel / 2, 0);
		}
		
		private function GetInCar(e:Event) {
			GameManager.sean.visible = false;
			GameManager.sean.ready = false;
			car.seanHead.visible = true;
			driveAway = true;
		}
		
		override public function Update():void 
		{
			super.Update();
			
			if (driveBy && !startedChat){
				if (car.x < GameManager.main.stage.stageWidth / 2) {
					if (car.x > 0 + GameManager.main.stage.stageWidth / 4) {
						if (!hornPlayed) {
							var channel:SoundChannel = new CarHorn().play(0, 0, transform2);
							channel = null;
							hornPlayed = true;
						}
						if(carSpeed > 2) {
							carSpeed--;
						}
					}
					if (car.x > 0 - car.width / 2) {
					}
					car.x += carSpeed;
				} else {
					driveBy = false;
					GameManager.sean.ready = false;
					chat.InitiateConversation(Conversations.cityViewConvo);
					chat.StartChat();
					startedChat = true;
				}
			} else if (driveAway) {
				if (car.x < GameManager.main.stage.stageWidth + car.width / 2 + 50) {
					car.x += carSpeed;
					if (car.x > GameManager.main.stage.stageWidth / 2 + 50) {
						carSpeed++;
						if (!screechPlayed) {
							channel = new CarScreech().play(0, 0, transform2);
							screechPlayed = true;
						}
					}
				} else {
					if(alpha - 0.05 >= 0) {
						alpha -= 0.05;
					} else {
						alpha = 0;
						SoundMixer.stopAll();
						GameManager.gameScreen.SetRoom(RoomNames.CITYVIEW, RoomNames.CITY);
					}
				}
			}
			
			if (startedChat && chat.GetChat() == null) {
				car.usable = true;
				GameManager.sean.ready = true;
			}
		}
	}
	

}