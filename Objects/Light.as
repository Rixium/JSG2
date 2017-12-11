package Objects 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import Helpers.RandomRange;
	import Constants.GameManager;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class Light extends MovieClip
	{
		
		var flashed:Boolean = false;
		public var canFlash:Boolean = true;
		
		public function Light(x:int, y:int, w:int, h:int) 
		{
				this.x = x;
				this.y = y;
				this.width = w;
				this.height = h;
				
				if(canFlash && GameManager.allowFlashing) {
					addEventListener(Event.ENTER_FRAME, Update);
				}
		}
		
		private function Update(e:Event) {
			if(canFlash && GameManager.allowFlashing) {
				if (flashed) {
					alpha = 1;
					flashed = false;
				}
				
				if(visible) {
					var shouldFlash:Boolean = (RandomRange.randomRange(0, 5) == 1);
					if (shouldFlash) {
						alpha = 0.8;
						flashed = true;
					}
				}
			}
		}
		
		public function Disable() {
			visible = false;
		}
		
		public function Enable() {
			visible = true;
		}
		
	}

}