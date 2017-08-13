package
{
	
	import Entity.Inventory;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import Constants.GameManager;
	
	public class UI extends MovieClip
	{
		
		public var objectDescriptor:TextField;
		public var staminaDisplay:TextField;
		public var healthDisplay:TextField;
		private var inventory:Inventory;
		
		var descriptionTimer:Timer = new Timer(3000, 1);
		private var stamina:int;
		private var health:int;
		
		public function UI()
		{
			mouseEnabled = false;
			//mouseChildren = false;
			descriptionTimer.addEventListener(TimerEvent.TIMER, ClearDescriptor);
		}
		
		public function SetDescriptor(s:String, permenant:Boolean):void {
			this.objectDescriptor.text = s;
			if(!permenant) {
				descriptionTimer.reset();
				descriptionTimer.start();
			} else {
				descriptionTimer.reset();
				descriptionTimer.stop();
			}
		}
		
		private function ClearDescriptor(e:TimerEvent) {
			objectDescriptor.text = "";
		}
		
		public function SetStamina(stamina:int):void {
			this.stamina = stamina;
			staminaDisplay.text = "Stamina: " + stamina;
		}
		
		public function SetHealth(health:int):void {
			this.health = health;
			healthDisplay.text = "Health: " + health;
		}
		
		public function SetInventory(i:Inventory):void {
			this.inventory = i;
			
			inventory.x = GameManager.main.stage.stageWidth / 2 - inventory.width / 2;
			inventory.y = 720 - 10 - 100;
			addChild(inventory);
			
			inventory.Initialize();
		}
		
		public function GetHealth():int {
			return this.health;
		}
		
		public function GetStamina():int {
			return this.stamina;
		}
		
	}
}