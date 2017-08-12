package 
{
	import flash.display.MovieClip;
	import Constants.GameManager;
	/**
	 * ...
	 * @author Rixium
	 */
	public class TextDisplay extends MovieClip
	{
		
		public function TextDisplay(s:String, x:int, y:int) 
		{
			text.text = s;
			this.x = x;
			this.y = y;
			GameManager.main.addChild(this);
		}
		
		public function Destroy():void {
			GameManager.main.removeChild(this);
		}
		
	}

}