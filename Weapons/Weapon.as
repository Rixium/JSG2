package Weapons 
{
	import flash.display.MovieClip;
	import Items.Item;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class Weapon extends MovieClip
	{
		
		var power:int;
		
		public function Weapon(weaponType:int, power:int)
		{
			gotoAndStop(weaponType);
			this.power = power;
		}
		
	}

}