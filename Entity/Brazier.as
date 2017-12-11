package Entity 
{
	import Constants.WeaponTypes;
	import Objects.Light;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import Constants.GameManager;
	import Sounds.*;
	/**
	 * ...
	 * @author Rixium
	 */
	public class Brazier extends EntityBase
	{
		
		public var on:Boolean = false;
		var lightSize = 800;
		
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
			if (e.GetWeapon().weaponType == WeaponTypes.TORCH && !on) {
				var light:Light;
				light = new Light(x + width / 2 - lightSize / 2, y - lightSize / 2, lightSize, lightSize);
				GameManager.gameScreen.GetRoom().lightMask.addChild(light);
				var trans:SoundTransform = new SoundTransform(GameManager.soundLevel, 0); 
				var channel:SoundChannel = new LightFire().play(0, 0, trans);
				trans = null;
				channel = null;
				this.description = "A lit brazier.";
				gotoAndStop("on");
				on = true;
				light = null;
			}
		}
	}

}