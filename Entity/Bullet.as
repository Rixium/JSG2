package Entity 
{
	/**
	 * ...
	 * @author Rixium
	 */
	
	 import Weapons.Weapon;
	 import flash.display.MovieClip;
	 import flash.events.Event;
	 import Constants.GameManager;
	 import Constants.WeaponTypes;

	public class Bullet extends MovieClip
	{
		var dir:Number;
		var dead:Boolean;
		var speed:int = 40;
		var damage:int = 5;
		var knockback:int = 0;
		var xScale;
		var yScale;
		
		var owner:EntityBase;
		
		public function Bullet(origin:EntityBase, weapon:Weapon, x:int, y:int, dir:Number) 
		{
			this.owner = origin;
			this.x = x;
			this.y = y;
			this.dir = dir;
			this.xScale = owner.xScale;
			this.yScale = owner.yScale;
			scaleX = xScale;
			scaleY = yScale;
			gotoAndStop(weapon.weaponType);
			
			if (weapon.weaponType == WeaponTypes.BOW) {
				speed = 20;
			}
			scaleX = dir;
		}

		public function Kill() {
			parent.removeChild(this);
		}
		
		public function GetOwner():EntityBase {
			return this.owner;
		}
		public function Update() {
			if (dir < 0) {
				x -= speed;
			} else {
				x += speed;
			}
			
			if (x < GameManager.gameScreen.GetRoom().GetLeftCollide().x + GameManager.gameScreen.GetRoom().GetLeftCollide().width  || x >= GameManager.gameScreen.GetRoom().GetRightCollide().x) {
				dead = true;
			}
		}
		
		public function GetDead():Boolean {
			return dead;
		}
		
		public function GetDamage():int {
			return damage;
		}
		
		public function GetKnockback():int {
			return knockback;
		}
		
		public function SetDead() {
			this.dead = true;
		}
		
	}

}