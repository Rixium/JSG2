package Screens {
	
	import Rooms.Room;
	import Rooms.SeansRoom;
	import flash.display.BitmapEncodingColorSpace;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
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
		
		
		public function GameScreen(main:Main) {
			
			main.gotoAndStop(1, "seanroom");
			
			GameManager.gameScreen = this;
			this.main = main;
			
			uiLayer = main.getChildByName("uiLayer") as MovieClip;
			uiLayer.mouseEnabled = false;
			
			roomLayer = main.getChildByName("roomLayer") as MovieClip;
			
			var ui:UI = new UI();
			GameManager.ui = ui;
			
			sean = new Sean(this);
			GameManager.sean = sean;

			SetRoom(new SeansRoom(RoomNames.NONE));
			
			
			main.addEventListener(Event.ENTER_FRAME, Update);
			sean.Initialize();
			
			
			
			mouseInfo = new MouseInfo();
			mouseInfo.x = main.stage.mouseX;
			mouseInfo.y = main.stage.mouseY;
			GameManager.mouseInfo = mouseInfo;
			uiLayer.addChild(mouseInfo);
			
			uiLayer.addChild(ui);
		}
		
		public function Update(e:Event):void {
			mouseInfo.x = main.stage.mouseX;
			mouseInfo.y = main.stage.mouseY;
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
			
			room = r;
			roomLayer.addChild(room);
			room.Initialize();
			room.AddObjects();
		}
		
	}
}