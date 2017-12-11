package Entity 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author Rixium
	 */
	public class Targetter extends MovieClip
	{
		
		public function Targetter() 
		{
			addEventListener("Kill", Kill);
		}
		
		private function Kill(e:Event) {
			removeEventListener("Kill", Kill);
			parent.removeChild(this);
		}
		
	}

}