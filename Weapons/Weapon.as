package Weapons 
{
	import Entity.EntityBase;
	import flash.display.MovieClip;
	import Items.Item;
	import Constants.GameManager;
	import Constants.WeaponSounds;
	import flash.geom.Point;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import Sounds.*;
	import Constants.WeaponTypes;
	import Constants.WeaponStyles;
	import Entity.Bullet;
	import Entity.Smoke;
	
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
		public var weaponStyle:int;
		
		public function Weapon(weaponType:int, power:int)
		{
			this.weaponType = weaponType;
			gotoAndStop(weaponType);
			this.power = power;
			knockback = 5;
			
			if (weaponType <= WeaponTypes.RAKE) {
				weaponStyle = WeaponStyles.SLASH;
			} else if(weaponType == WeaponTypes.SHOTGUN) {
				weaponStyle = WeaponStyles.SHOTGUN;
			} else if (weaponType == WeaponTypes.BOW) {
				weaponStyle = WeaponStyles.BOW;
			}
		}
		
		public function PlaySound() {
			var trans:SoundTransform = new SoundTransform(GameManager.soundLevel, 0); 
			var channel:SoundChannel = WeaponSounds.GetSound(weaponType).play(0, 1, trans);
			trans = null;
			channel = null;
		}
		
		public function Shoot(dir:Number, owner:EntityBase) {
			var bullet:Bullet = new Bullet(owner, this, spawnPoint.getBounds(GameManager.gameScreen.roomLayer).x, spawnPoint.getBounds(GameManager.gameScreen.roomLayer).y, dir);
			GameManager.gameScreen.GetRoom().AddBullet(bullet);
			GameManager.gameScreen.GetRoom().addChild(new Smoke(spawnPoint.getBounds(GameManager.gameScreen.roomLayer).x, spawnPoint.getBounds(GameManager.gameScreen.roomLayer).y));
			bullet = null;
		}
	}

}