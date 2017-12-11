package Helpers 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Constants.GameManager;
	/**
	 * ...
	 * @author Rixium
	 */
	public class Slider extends MovieClip
	{
		
		public var sliderPosition:Number = 0;
		
		public function Slider() 
		{
		}
		
		public function Initialize(startPosPercent:Number) {
			slider.x = startPosPercent * line.width;
			sliderPosition = slider.x / line.width;
			slider.addEventListener(MouseEvent.MOUSE_DOWN, MouseHeld);
		}
		
		public function Deactivate() {
			slider.removeEventListener(MouseEvent.MOUSE_DOWN, MouseHeld);
		}
		
		private function Tick(e:Event) {

			if (mouseX > line.width) {
				slider.x = line.width;
			} else if (mouseX < 0) {
				slider.x = 0;
			} else {
				slider.x = mouseX;
			}
			
			sliderPosition = slider.x / line.width;
		}
		
		private function MouseReleased(e:MouseEvent) {
			removeEventListener(Event.ENTER_FRAME, Tick);
			GameManager.main.stage.removeEventListener(MouseEvent.MOUSE_UP, MouseReleased);
		}
		
		private function MouseHeld(e:MouseEvent) {
			addEventListener(Event.ENTER_FRAME, Tick);
			GameManager.main.stage.addEventListener(MouseEvent.MOUSE_UP, MouseReleased);
		}
		
		
	}

}