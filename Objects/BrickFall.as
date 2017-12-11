package Objects 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import Constants.GameManager;
	/**
	 * ...
	 * @author Rixium
	 */
	public class BrickFall extends ObjectBase
	{
		
		public function BrickFall(x:int, y:int) 
		{
			interactable = false;
			this.x = x;
			this.y = y;
			addEventListener("fallen", CheckHit);
		}
		
		public function Kill() {
			removeEventListener("fallen", CheckHit);
			parent.removeChild(this);
		}
		
		private function CheckHit(e:Event) {
			if (stage) {
				if(!GameManager.maIsDead) {
					GameManager.gameScreen.GetRoom().DamageEntities(hitarea, 20, 20);
				}
				removeEventListener("fallen", CheckHit);
				parent.removeChild(this);
			}
		}
		
	}

}