package Items 
{
	
	import Constants.ItemTypes;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class WeaponItem extends Item 
	{

		public var weaponType:int;
		public var power:int;
		
		
		public function WeaponItem(itemImage:int, weaponType:int, power:int) 
		{
			super(itemImage, ItemTypes.WEAPON);
			this.weaponType = weaponType;
			this.power = power;
			gotoAndStop(itemImage);
		}
		
		public function Equip() {
			
		}
		
	}

}