package Screens {
	
	import Rooms.Room;
	import Rooms.SeansRoom;
	import flash.display.BitmapEncodingColorSpace;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.system.System;
	
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
		
		
		public function GameScreen() {
			GameManager.main.gotoAndStop(1, "seanroom");
			
			GameManager.gameScreen = this;
			
			uiLayer = GameManager.main.getChildByName("uiLayer") as MovieClip;
			uiLayer.mouseEnabled = false;
			
			roomLayer = GameManager.main.getChildByName("roomLayer") as MovieClip;
			
			var ui:UI = new UI();
			GameManager.ui = ui;
			
			sean = new Sean(this);
			GameManager.sean = sean;

			SetRoom(new SeansRoom(RoomNames.NONE));
			
			
			GameManager.main.addEventListener(Event.ENTER_FRAME, Update);
			sean.Initialize();
			
			
			
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
			sean.Update();
		}
		
		public function GetRoom():Room {
			return this.room;
		}
		
		public function SetRoom(r:Room):void {
			if(room != null) {
				roomLayer.removeChild(room);
			}

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