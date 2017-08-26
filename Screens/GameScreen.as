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
	
	import Constants.GameManager;
	
	import Entity.EntityBase;
	import Entity.Sean;
	import Constants.RoomNames;
	
	import Objects.*;
	
	import MouseInfo;
	
	public class GameScreen extends Screen {
		
		private var sean:Sean;
		private var room:Room;
		private var mouseInfo:MouseInfo;
		
		private var roomLayer:MovieClip;
		private var uiLayer:MovieClip;
		private var rectangle:Rectangle;
		private var followSean:Boolean = false;
		var gameTimer:Timer;
		
		private var channel:SoundChannel;
		private var trans:SoundTransform;
		
		
		public function GameScreen() {
			GameManager.main.gotoAndStop(1, "seanroom");
			
			GameManager.gameScreen = this;
			trans = new SoundTransform(GameManager.musicLevel, 0); 
			
			uiLayer = GameManager.main.getChildByName("uiLayer") as MovieClip;
			uiLayer.mouseEnabled = false;
			
			roomLayer = GameManager.main.getChildByName("roomLayer") as MovieClip;
			
			var ui:UI = new UI();
			GameManager.ui = ui;
			
			sean = new Sean(this);
			GameManager.sean = sean;

			SetRoom(RoomNames.NONE, RoomNames.SEANSROOM);
			
			rectangle = roomLayer.scrollRect;
			
			sean.Initialize();
			GameManager.main.addEventListener(Event.ENTER_FRAME, Update);
			
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
		
		public function Update(e:Event):void {
			mouseInfo.x = GameManager.main.stage.mouseX;
			mouseInfo.y = GameManager.main.stage.mouseY;
			//sean.Update();
			
			if (room != null) {
				if(room.canUpdate) {
					room.Update();
				}
			}
			// Maybe keep?
			if(followSean) {
				roomLayer.scrollRect = new Rectangle(sean.x - GameManager.main.stage.stageWidth / 2, sean.y - GameManager.main.stage.stageHeight / 2, GameManager.main.stage.stageWidth, GameManager.main.stage.stageHeight);
			} else {
				roomLayer.scrollRect = rectangle;
			}
		}
		
		public function Follow(follow:Boolean):void {
			followSean = follow;
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
		
		public function PlayTrack(song:Sound, loop:Boolean) {
			if(loop) {
				channel = song.play(0, 9999, trans);
			} else {
				channel = song.play(0, 0, trans);
			}
		}
		
		public function StopTrack() {
			channel.stop();
		}
	}
}