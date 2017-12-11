package Objects 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Rixium
	 */
	
	
	public class MarkiplierCar extends UsableObject 
	{
		
		var startY;
		var goUp = true;
		var goDown = false;
		
		public function MarkiplierCar() 
		{
			super();
			this.x = x;
			this.y = y;
			startY = y;
			this.interactable = true;
			this.collidable = true;
			useText = "Enter";
			description = "A Dashing pink automobile.";
			displayName = "Markipliers' Car";
			addEventListener(Event.ENTER_FRAME, Vibrate);
			seanHead.visible = false;
			initialized = true;
			
		}
		
		public function Kill() {
			parent.removeChild(this);
		}
		
		private function Vibrate(e:Event) {
			if (goUp) {
				if (y > startY - .5) {
					y -= 0.3;
				} else {
					goUp = false;
					goDown = true;
				}
			} else if (goDown) {
				if (y < startY) {
					y += 0.3;
				} else {
					goUp = true;
					goDown = false;
				}
			}
		}
		
		override protected function Use():void 
		{
			if(usable) {
				super.Use();
				dispatchEvent(new Event("Used"));
			}
		}
		
	}

}