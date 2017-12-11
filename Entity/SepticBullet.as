package Entity 
{
	import flash.display.MovieClip;
	import Constants.GameManager;
	/**
	 * ...
	 * @author Rixium
	 */
	public class SepticBullet extends MovieClip
	{
		
		var dir:Number = 0;
		public var canDie:Boolean = false;
		public function SepticBullet(x:int, y:int, dir:Number) 
		{
			this.x = x;
			this.y = y;
			this.dir = dir;
		}
		
		public function Update() {
			x += Math.cos(dir) * 10;
			y += Math.sin(dir) * 10;
			
			if(!canDie) {
				if (getBounds(GameManager.gameScreen.GetRoom()).x - width / 2 < 0 || getBounds(GameManager.gameScreen.GetRoom()).x > GameManager.main.stage.stageWidth + width / 2 || getBounds(GameManager.gameScreen.GetRoom()).y - height / 2 < 0|| getBounds(GameManager.gameScreen.GetRoom()).y > GameManager.main.stage.stageHeight + height / 2) {
					canDie = true;
				}
			}
		}
		
		public function Kill() {
			parent.removeChild(this);
		}
		
	}

}