package Constants
{
	
	import Entity.Sean;
	import Screens.GameScreen;
	
	public class GameManager
	{
		
		public static var main:Main;
		public static var gameScreen:GameScreen;
		public static var mouseText:String = "";
		public static var mouseInfo:MouseInfo;
		public static var sean:Sean;
		public static var ui:UI;
		
		public static var soundLevel = 1;
		public static var musicLevel = .25;
		public static var allowFlashing = true;
		
		public static var maKilled = false;
		public static var visitedMa = false;
		
		public static var firstTimeSam = true;
		public static var maIsDead = false;
		
		public static var collectedBooks:int = 0;
		public static var gotSepticSword = false;
		public static var healthUpgrades:int = 0;
		
		public static var gameComplete:Boolean = false;
		
		public static var staminaUpgrades:int = 0;

		public static function ResetManager() {
			if(gameScreen != null) {
				gameScreen.Destroy();
			}
			Conversations.Reset();
			RoomNames.Reset();
			gameScreen = null;
			mouseText = null;
			mouseInfo = null;
			sean = null;
			ui = null;
			maKilled = false;
			visitedMa = false;
			firstTimeSam = true;
			maIsDead = false;
			collectedBooks = 0;
			gotSepticSword = false;
			healthUpgrades = 0;
			staminaUpgrades = 0;
			
			
		}
	}
}