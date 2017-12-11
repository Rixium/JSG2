package Entity 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class Tentacle extends MovieClip 
	{
		
		public function Tentacle(x:int, y:int) 
		{
			super();
			this.x = x;
			this.y = y;
		}
		
		private function Update(e:Event) {
			this.height -= 30;
			alpha -= 0.05;
			if (height < 150 || alpha <= 0) {
				removeEventListener(Event.ENTER_FRAME, Update);
				parent.removeChild(this);
			}
		}
		
		public function Kill() {
			addEventListener(Event.ENTER_FRAME, Update);
			
		}
		
		
	}

}