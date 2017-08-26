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
		var e:EntityBase;
		
		public function WeaponSlot(e:EntityBase) 
		{
			super();
			this.e = e;
		}
		
		public function SetWeapon(weapon:Weapon):void {
			if (this.weapon != null) {
				removeChild(this.weapon);
			}
			this.weapon = weapon;
			weapon.holder = this.e;
			addChild(weapon);
		}
		
		public function GetWeapon():Weapon {
			return weapon;
		}
		
		public function RemoveWeapon() {
			removeChild(this.weapon);
			this.weapon = null;
		}
	}

}