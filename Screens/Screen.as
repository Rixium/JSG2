package Screens {
	
	import flash.display.MovieClip;
	
	public class Screen extends MovieClip {
		
		protected var main:Main;
		
		public function Screen() {
			
		}
		
		protected function AddToStage(screen:MovieClip) {
			main.addChild(screen);
		}
		
		protected function RemoveFromStage(screen:MovieClip) {
			main.removeChild(screen);
		}
	}
}