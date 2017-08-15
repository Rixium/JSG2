package UIObjects 
{
	import flash.display.MovieClip;
	import Constants.GameManager;
	/**
	 * ...
	 * @author Rixium
	 */
	public class HealthBar extends MovieClip
	{
		
		private var startWidth:int;
		
		public function HealthBar() 
		{
			startWidth = 100;
			innerSize.width = startWidth;
			edge1.x = barInside.x + startWidth - 1;
		}
		
		public function Set(count:int, compare:int) {
			barInside.width = count / compare * startWidth;
		}
		
		public function Upgrade(count:int) {
			startWidth += count;
			innerSize.width = startWidth;
			edge1.x = barInside.x + startWidth - 1;
		}
	}

}