package Entity 
{
	
	import Constants.GameManager;
	import Sounds.HurtOne;
	import UIObjects.HealthBar;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import Weapons.Weapon;
	import Sounds.*;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class Zombie extends EnemyBase 
	{
	
		var startScaleX:int;
		var startScaleY:int;
		var startedWalking = false;
		var startWidthHealthBar:Number;
		var attacking:Boolean = false;
		
		public function Zombie(x:int, y:int, health:int, stamina:int, weapon:Weapon) 
		{
			super();
			displayName = "Corrupt";
			description = "A strange aura surrounds it.";
			stats = new Stats(5, 50, stamina);
			this.scaleX = 2;
			this.scaleY = 2;
			startScaleX = scaleX;
			startScaleY = scaleY;
			this.x = x;
			this.y = y;
			startWidthHealthBar = healthbar.width;
			weaponSlot = new WeaponSlot(this);
			weaponSlot.SetWeapon(weapon);
			body.weaponHolder.addChild(weaponSlot);
			
			this.hurtSounds = new Array(new HurtOne());
		}
		
		private function Attack() {
			if (!attacking && stats.stamina > AbilityCosts.ATTACK) {
				stats.stamina -= AbilityCosts.ATTACK;
				attacking = true;
				body.gotoAndPlay("Attack");
				body.addEventListener("CheckHit", CheckHit); 
				addEventListener("AttackFinished", AttackFinished);
			}
		}
		
		private function CheckHit(e:Event) {
				GameManager.gameScreen.GetRoom().AttackEntities(this, weaponSlot.GetWeapon());
				body.removeEventListener("CheckHit", CheckHit);
		}
		
		private function AttackFinished(e:Event) {
			removeEventListener("AttackFinished", AttackFinished);
			attacking = false;
			body.gotoAndStop("Idle");
		}
		
		private function Die() {
			if (currentLabel != "dying") {
				addEventListener("dead", Kill);
				gotoAndPlay("dying");
				dead = true;
			}
		}
		
		public override function Update():void {
			if(!dead) {
				if(stats.stamina < stats.maxStamina) {
						stats.stamina++;
				}
				
				var dist:Number = Math.floor(getDistance(GameManager.sean, this));
				healthbar.width = stats.health / stats.maxHealth * startWidthHealthBar;
				if (dist < stats.vision && !knockedBack && dist > GameManager.sean.width) {
					if(!startedWalking) {
						legs.legs.gotoAndPlay("Walk");
						startedWalking = true;
					}
					var eRect:Rectangle = GameManager.sean.getBounds(stage);
					var entityRect:Rectangle = getBounds(stage);
					var dir:Number = Math.atan2((eRect.y + eRect.height) / 2 - (entityRect.y + entityRect.height) / 2, (eRect.x + eRect.width) / 2 - (entityRect.x + entityRect.width) / 2);
					var oldX = x;
					var oldY = y;
					var xChange = Math.cos(dir) * stats.speed;
					var yChange = Math.sin(dir) * stats.speed;
					if (xChange < 0) {
						scaleX = -startScaleX;
					} else {
						scaleX = startScaleX;
					}
					x +=  xChange;
					y +=  yChange;
					
					if(!GameManager.gameScreen.GetRoom().CheckAble(this, false)) {
						x = oldX;
						y = oldY;
					}
					
					eRect = null;
					entityRect = null;
					
				} else if(dist >= stats.vision){
					startedWalking = false;
					legs.legs.gotoAndStop("Idle");
				} else if (dist <= GameManager.sean.width + 30 && !attacking) {
					startedWalking = false;
					legs.legs.gotoAndStop("Idle");
					Attack();
				}
				
				if (stats.health <= 0) {
					stats.health = 0;
					Die();
				}
			}
		}

	}

}