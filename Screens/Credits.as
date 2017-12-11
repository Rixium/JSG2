package Screens 
{
	/**
	 * ...
	 * @author Rixium
	 */
	import Constants.GameManager;
	
	public class Credits extends Screen
	{
		
		public function Credits() 
		{
			GameManager.main.gotoAndPlay(1, "credits");
		}
		
	}

}