package {
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import Screens.Menu;
	import Constants.GameManager;
	import Screens.Screen;

	public class Main extends MovieClip {
		
		var currentScreen:Screen;
		var loader:LoaderScreen;

		public function Main() {
			this.addEventListener(Event.ADDED_TO_STAGE, GameLoaded);
		}
		
		public function GameLoaded(e:Event):void {
			Lock();
			removeEventListener(Event.ADDED_TO_STAGE, GameLoaded);
			stage.addEventListener(MouseEvent.RIGHT_CLICK, RightClick);
			MovieClip(root).gotoAndStop(1, "menu");
			GameManager.main.StartMenu();
		}
		
		public function Lock() {
			SiteLock.registerStage(stage);
			SiteLock.allowLocalPlay(true);
			SiteLock.checkURL(true);
		}
		
		public function StartMenu() {
			currentScreen = new Menu(this);
		}
		
		public function SetScreen(screen:Screen):void {
			this.currentScreen = screen;
		}
		
		private function RightClick(e:MouseEvent) {
			
		}
		
		
	}
}