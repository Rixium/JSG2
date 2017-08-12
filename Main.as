﻿package {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import Screens.Menu;
	import Constants.GameManager;
	import Screens.Screen;
	
	public class Main extends MovieClip {
		
		var currentScreen:Screen;
		var loader:LoaderScreen;
		
		public function Main() {
			GameManager.main = this;
			addEventListener("gameloaded", GameLoaded);
			loader = new LoaderScreen();
			loader.x = 0;
			loader.y = 0;
			addChild(loader);
		}
		
		private function GameLoaded(e:Event):void {
			removeChild(loader);
			MovieClip(root).gotoAndStop(1, "menu");
			currentScreen = new Menu(this);
		}
		
		public function SetScreen(screen:Screen):void {
			this.currentScreen = screen;
		}
	}
}