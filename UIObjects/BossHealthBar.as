package UIObjects 
{
	import flash.display.MovieClip;
	import Constants.GameManager;
	/**
	 * ...
	 * @author Rixium
	 */
	public class BossHealthBar extends MovieClip
	{
		
		private var startWidth:int;
		
		public function BossHealthBar(startHealth:int) 
		{
			startWidth = GameManager.main.stage.stageWidth;
			healthBar.width = startWidth;
			health.text = startHealth + " / " + startHealth;
			x = GameManager.main.stage.stageWidth / 2;
			y = 0;
		}
		
		public function Set(count:int, compare:int) {
			health.text = count + " / " + compare;
			healthBar.width = count / compare * startWidth;
		}
		
		public function Kill() {
			if(parent != null) {
				parent.removeChild(this);
			} else {
				visible = false;
			}
		}
	}

}