package Weapons 
{
	import Entity.EntityBase;
	import flash.display.MovieClip;
	import Items.Item;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class Weapon extends MovieClip
	{
		
		public var power:int;
		public var knockback:int;
		public var weaponType;
		public var holder:EntityBase;
		
		public function Weapon(weaponType:int, power:int)
		{
			this.weaponType = weaponType;
			gotoAndStop(weaponType);
			this.power = power;
			knockback = 5;
		}
		
	}

}