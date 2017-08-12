package
{
	
	import flash.display.MovieClip;
	
	import Constants.GameManager;
	
	public class MouseInfo extends MovieClip
	{

		public function MouseInfo()
		{
			
		}
		
		public function SetText(s:String):void {
			text.text = s;
		}
		
		public function GetText():String {
			return text.text;
		}
	}
}