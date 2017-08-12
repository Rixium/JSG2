package Screens {
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.StageQuality;
	import Constants.GameManager;
	
	public class Menu extends Screen {
		
		var mainMenu:MainMenu;
		
		public function Menu(main:Main) {
			this.main = main;
			main.addEventListener("menuready", MenuReady);
			mainMenu = new MainMenu();
			mainMenu.x = 640;
			mainMenu.y = 360;
			AddToStage(mainMenu);
		}
		
		private function MenuReady(e:Event):void {
			mainMenu.getChildByName("playButton").addEventListener(MouseEvent.CLICK, StartGame);
			mainMenu.getChildByName("optionsButton").addEventListener(MouseEvent.CLICK, ShowOptions);
		}
		
		private function StartGame(e:MouseEvent):void {
			RemoveFromStage(mainMenu);
			main.SetScreen(new GameScreen(main));
		}
		
		private function ShowOptions(e:MouseEvent):void {
			mainMenu.gotoAndStop("options");
			mainMenu.getChildByName("potatoButton").addEventListener(MouseEvent.CLICK, PotatoQuality);
			mainMenu.getChildByName("pooButton").addEventListener(MouseEvent.CLICK, PooQuality);
			mainMenu.getChildByName("diamondButton").addEventListener(MouseEvent.CLICK, DiamondQuality);
			mainMenu.backButton.addEventListener(MouseEvent.CLICK, ShowMain);
		}
		
		private function PotatoQuality(e:MouseEvent):void {
			main.stage.quality = StageQuality.LOW;
		}
		
		private function PooQuality(e:MouseEvent):void {
			main.stage.quality = StageQuality.MEDIUM;
		}
		
		private function DiamondQuality(e:MouseEvent):void {
			main.stage.quality = StageQuality.BEST;
		}
		
		private function ShowMain(e:MouseEvent):void {
			mainMenu.gotoAndStop("menu");
		}
	}
}