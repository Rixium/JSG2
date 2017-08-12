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
	
	import Objects.*;
	
	import MouseInfo;
	
	public class GameScreen extends Screen {
		
		private var sean:Sean;
		private var room:Room;
		private var mouseInfo:MouseInfo;
		
		public function GameScreen(main:Main) {
			
			this.main = main;
			var ui:UI = new UI();
			GameManager.ui = ui;
			
			sean = new Sean(this);
			GameManager.sean = sean;

			room = new SeansRoom();
			main.addChild(room);
			room.Initialize();
			room.AddObjects();
			
			main.addEventListener(Event.ENTER_FRAME, Update);
			sean.Initialize();
			
			
			
			mouseInfo = new MouseInfo();
			mouseInfo.x = main.stage.mouseX;
			mouseInfo.y = main.stage.mouseY;
			GameManager.mouseInfo = mouseInfo;
			main.addChild(mouseInfo);
			
			main.addChild(ui);
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
			this.room = r;
		}
		
	}
}