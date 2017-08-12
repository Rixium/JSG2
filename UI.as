package
{
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class UI extends MovieClip
	{
		
		public var objectDescriptor:TextField;
		public var staminaDisplay:TextField;
		public var healthDisplay:TextField;
		
		var descriptionTimer:Timer = new Timer(3000, 1);
		
		
		public function UI()
		{
			mouseEnabled = false;
			mouseChildren = false;
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
			staminaDisplay.text = "Stamina: " + stamina;
		}
		
		public function SetHealth(health:int):void {
			healthDisplay.text = "Health: " + health;
		}
		
	}
}