package UIObjects 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import Constants.GameManager;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class CheckConfirm extends MovieClip 
	{
		
		public var active:Boolean = false;
		private var confirm:Boolean = false;
		
		
		public function CheckConfirm() 
		{
			super();
			x = GameManager.main.stage.stageWidth / 2;
			y = GameManager.main.stage.stageHeight / 2;
		}
		
		public function Kill() {
			GameManager.sean.ready = true;
			parent.removeChild(this);
			GameManager.main.stage.focus = GameManager.gameScreen.roomLayer;
		}
		
		public function Initialize() {
			GameManager.sean.ready = false;
			yes.addEventListener(MouseEvent.CLICK, Yes);
			no.addEventListener(MouseEvent.CLICK, No);
		}
		
		private function Yes(e:MouseEvent) {
			confirm = true;
			yes.removeEventListener(MouseEvent.CLICK, Yes);
			dispatchEvent(new Event("Checked"));
		}
		
		public function Check():Boolean {
			return confirm;
		}
		
		private function No(e:MouseEvent) {
			confirm = false;
			no.removeEventListener(MouseEvent.CLICK, No);
			dispatchEvent(new Event("Checked"));
		}
	}

}