package 
{
	import flash.display.MovieClip;
	import Constants.Keys;
	import Constants.GameManager;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author Rixium
	 */
	public class KeyGetter extends MovieClip
	{
		var k:int = -1;
		var keyPicked:Boolean;
		
		public function KeyGetter() 
		{
			GameManager.main.stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyPicked);
		}
		
		public function GetKey():int {
			return k;
		}
		
		private function KeyPicked(e:KeyboardEvent) {
			k = e.keyCode;
		}
		
		public function Reset() {
			k = -1;
		}
		
	}

}