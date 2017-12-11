package Entity 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author Rixium
	 */
	public class Smoke extends MovieClip
	{

		public function Smoke(x:int, y:int) 
		{
			this.x = x;
			this.y = y;
			addEventListener("Finished", Kill);
		}
		
		public function Kill(e:Event) {
			removeEventListener("Finished", Kill);
			parent.removeChild(this);
		}
		
	}

}