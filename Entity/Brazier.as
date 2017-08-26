package Entity 
{
	import Constants.WeaponTypes;
	/**
	 * ...
	 * @author Rixium
	 */
	public class Brazier extends EntityBase
	{
		
		public var on:Boolean = false;
		
		public function Brazier(x:int, y:int, width:int, height:int) 
		{
			super();
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			this.displayName = "Brazier";
			this.description = "An unlit brazier.";
		}
		
		public override function Hit(e:EntityBase, power:int, knockback:int, dir:Number) {
			if (e.GetWeapon().weaponType == WeaponTypes.TORCH) {
				this.description = "A lit brazier.";
				gotoAndStop("on");
				on = true;
			}
		}
	}

}