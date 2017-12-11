package Screens {
	
	import Rooms.Room;
	import Rooms.SeansRoom;
	import flash.display.BitmapEncodingColorSpace;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.system.System;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import Screens.PauseScreen;
	import Constants.GameManager;
	import Constants.Keys;
	import Entity.EntityBase;
	import Entity.Sean;
	import Constants.RoomNames;
	
	import Objects.*;
	import MouseInfo;
	
	public class GameScreen extends Screen {
		
		private var sean:Sean;
		private var room:Room;
		private var mouseInfo:MouseInfo;
		
		public var roomLayer:MovieClip;
		private var uiLayer:MovieClip;
		private var rectangle:Rectangle;
		private var followSean:Boolean = false;
		var gameTimer:Timer;
		
		private var channel:SoundChannel;
		private var trans:SoundTransform;
		var rect:Rectangle;
		var goalRect:Rectangle;
		public var musicManager:MusicManager = new MusicManager();
		var moveTo:Boolean = false;
		var camSpeed:int = 15;
		var followClip:MovieClip;
		var followEntity:Boolean = false;
		var pauseScreen:PauseScreen;
		public var paused:Boolean = false;
		var adShowing:Boolean = false;;
		
		private function muteMusic() {
			paused = true;
			adShowing = true;
			GameManager.gameScreen.musicManager.Mute();
		}
		
		private function unMuteMusic() {
			paused = false;
			adShowing = false;
			GameManager.gameScreen.musicManager.UnMute();
		}
		
		public function GameScreen() {
			GameManager.main.stage.stageFocusRect = false;
			GameManager.main.gotoAndStop(1, "seanroom");
			
						
			GameManager.gameScreen = this;
			trans = new SoundTransform(GameManager.musicLevel, 0); 
			
			uiLayer = GameManager.main.getChildByName("uiLayer") as MovieClip;
			uiLayer.mouseEnabled = false;
			
			roomLayer = GameManager.main.getChildByName("roomLayer") as MovieClip;
			rectangle = new Rectangle(0, 0, GameManager.main.stage.stageWidth, GameManager.main.stage.stageHeight);
			var ui:UI = new UI();
			GameManager.ui = ui;
			
			sean = new Sean(this);
			GameManager.sean = sean;

			SetRoom(RoomNames.NONE, RoomNames.SEANSROOM);

			sean.Initialize();
			GameManager.main.addEventListener(Event.ENTER_FRAME, Update);
			GameManager.main.stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			// If I decide on camera.. Maybe not.
			//roomLayer.scrollRect = new Rectangle(sean.x - GameManager.main.stage.stageWidth / 2, sean.y - GameManager.main.stage.stageHeight / 2, GameManager.main.stage.stageWidth, GameManager.main.stage.stageHeight);
			
			mouseInfo = new MouseInfo();
			mouseInfo.x = GameManager.main.stage.mouseX;
			mouseInfo.y = GameManager.main.stage.mouseY;
			GameManager.mouseInfo = mouseInfo;
			
			
			uiLayer.addChild(ui);
			uiLayer.addChild(mouseInfo);
			
			
			ui = null;

		}
		
		public function Destroy() {
			GameManager.main.removeEventListener(Event.ENTER_FRAME, Update);
			GameManager.main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			GameManager.sean.Destroy();
			room = null;
		}
		
		public function Update(e:Event):void {
			if(!paused) {
				GameManager.ui.Update();
				mouseInfo.x = GameManager.main.stage.mouseX;
				mouseInfo.y = GameManager.main.stage.mouseY;
				//sean.Update();
				
				if (room != null) {
					if(room.canUpdate) {
						room.Update();
					}
				}
				// Maybe keep?
				if (followSean) {
					roomLayer.scrollRect = new Rectangle((sean.x - GameManager.main.stage.stageWidth / 2), (sean.y - GameManager.main.stage.stageHeight / 2), GameManager.main.stage.stageWidth, GameManager.main.stage.stageHeight);
				} else {
					roomLayer.scrollRect = rectangle;
				}
				
				if (followEntity) {
					roomLayer.scrollRect = new Rectangle((followClip.x - GameManager.main.stage.stageWidth / 2), (followClip.y - GameManager.main.stage.stageHeight / 2), GameManager.main.stage.stageWidth, GameManager.main.stage.stageHeight);
				}
				
				musicManager.Update();
			}
		}
		
		private function KeyDown(e:KeyboardEvent) {
			if (e.keyCode == Keys.PAUSE && !adShowing) {
				if (!paused) {
					paused = true;
					if (pauseScreen == null) {
						pauseScreen = new PauseScreen();
					}
					GameManager.main.addChild(pauseScreen);
					pauseScreen.Added();
				} else {
					paused = false;
					GameManager.main.removeChild(pauseScreen);
					pauseScreen.Removed();
				}
			}
		}
		
		public function Follow(follow:Boolean):void {
			rect = new Rectangle(rectangle.x, rectangle.y, rectangle.width, rectangle.height);
			followSean = follow;
			if (follow) {
				moveTo = true;
			}
		}
		
		public function StopFollowEntity() {
			followEntity = false;
			followClip = null;
		}
		public function FollowEntity(entity:MovieClip) {
			followClip = entity;
			followEntity = true;
		}

		public function GetRoom():Room {
			return this.room;
		}
		
		public function SetRoom(currentRoom:int, newRoom:int):void {
			if (room != null) {
				roomLayer.removeChild(room);
				room.Clean();
			}

			var r:Room = RoomNames.GetRoom(currentRoom, newRoom);
			
			GameManager.ui.SetDescriptor("", true);
			
			if (mouseInfo != null) {
					mouseInfo.SetText("");
			}
			
			room = r;
			roomLayer.addChild(room);
			room.gotoAndPlay(1);
			GameManager.main.stage.focus = roomLayer;
			GameManager.main.stage.stageFocusRect = false;
			room.Initialize();
			room.AddObjects();
		}
		
	}
}