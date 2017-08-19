package Entity 
{
	import Weapons.Weapon;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class WeaponSlot extends MovieClip 
	{
		
		private var weapon:Weapon;
		
		public function WeaponSlot() 
		{
			super();
			
		}
		
		public function SetWeapon(weapon:Weapon):void {
			if (this.weapon != null) {
				removeChild(this.weapon);
			}
			this.weapon = weapon;
			addChild(weapon);
		}
		
		public function GetWeapon():Weapon {
			return weapon;
		}
	}

}