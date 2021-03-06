package
{
	
	import Entity.DescriptionBox;
	import Entity.Inventory;
	import UIObjects.HealthBar;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import Constants.GameManager;
	import flash.geom.ColorTransform;
	
	public class UI extends MovieClip
	{
		
		public var objectDescriptor:TextField;
		public var staminaDisplay:TextField;
		public var healthDisplay:TextField;
		public var inventory:Inventory;
		
		var descriptionTimer:Timer = new Timer(3000, 1);
		private var stamina:int;
		private var health:int;
		
		private var healthBar:HealthBar = new HealthBar();
		private var staminaBar:HealthBar = new HealthBar();
		private var boxes:Array = [];
		
		public function UI()
		{
			mouseEnabled = false;
			//mouseChildren = false;
			descriptionTimer.addEventListener(TimerEvent.TIMER, ClearDescriptor);
			
			healthBar.x = 10;
			healthBar.y = 10;
			addChild(healthBar);
			
			var myColorTransform = new ColorTransform();
			myColorTransform.color = 0x32CD32;
			staminaBar.barInside.transform.colorTransform = myColorTransform;
			staminaBar.x = 10;
			staminaBar.y = 10 + staminaBar.height + 10;
			addChild(staminaBar);
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
		
		public function SetHealthBarPos(yPos:int) {
			healthBar.y = yPos;
			staminaBar.y = yPos + staminaBar.height + 10;
		}
		
		public function Update() {
			for (var i:int = 0; i < boxes.length; i++) {
				var box:DescriptionBox = boxes[i] as DescriptionBox;
				box.Update();
				if (box.dead) {
					boxes.removeAt(i);
					GameManager.gameScreen.GetRoom().removeChild(box);
					break;
				}
			}
		}
		public function UpgradeStamina(amount:int) {
			staminaBar.Upgrade(amount);
		}
		
		public function AddDescriptor(box:DescriptionBox) {
			boxes.push(box);
			GameManager.gameScreen.GetRoom().addChild(box);
		}
		
		public function UpgradeHealth(amount:int) {
			healthBar.Upgrade(amount);
		}
		
		private function ClearDescriptor(e:TimerEvent) {
			objectDescriptor.text = "";
		}
		
		public function SetStamina(stamina:int):void {
			this.stamina = stamina;
			staminaBar.Set(stamina, GameManager.sean.GetStats().maxStamina);
		}
		
		public function SetHealth(health:int):void {
			this.health = health;
			healthBar.Set(health, GameManager.sean.GetStats().maxHealth);
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