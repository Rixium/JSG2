package Constants 
{
	import Sounds.FireSlash;
	import flash.media.Sound;
	import Sounds.*;
	/**
	 * ...
	 * @author Rixium
	 */
	public class WeaponSounds 
	{
		
		public function WeaponSounds() 
		{
			
		}
		
		public static function GetSound(weaponType:int):Sound {
			switch(weaponType) {
				case WeaponTypes.SEPTICSWORD:
				case WeaponTypes.BUTCHERSKNIFE:
				case WeaponTypes.RAKE:
				case WeaponTypes.SEPTICSWORD:
				case WeaponTypes.STICK:
					var slashSounds:Array = new Array(new SlashOne(), new SlashTwo(), new SlashThree(), new SlashFour());
					var choice:Sound = slashSounds[randomRange(0, slashSounds.length - 1)] as Sound;
					return choice;
				case WeaponTypes.TORCH:
					return new FireSlash();
				case WeaponTypes.SHOTGUN:
					return new BulletOne();
				case WeaponTypes.BOW:
					return new ArrowSound();
				default:
					break;
			}
			
			return null;
		}
		
		static function randomRange(minNum:Number, maxNum:Number):Number 
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
	}

}