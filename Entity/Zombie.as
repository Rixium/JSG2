package Entity 
{
	
	import Constants.GameManager;
	import Constants.ZombieHeads;
	import Sounds.HurtOne;
	import UIObjects.HealthBar;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import Weapons.Weapon;
	import Sounds.*;
	import Constants.WeaponTypes;
	import flash.media.SoundTransform;
	
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
		var hasDestination:Boolean = false;
		var destX:int;
		var destY:int;
		
		var hasShot:Boolean = false;
		var hasShotTimer:int = 0;
		
		public function Zombie(x:int, y:int, health:int, stamina:int, weapon:Weapon, headtype:int) 
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
			
			if (headtype == ZombieHeads.RANDOM) {
				head.gotoAndStop(randomRange(1, ZombieHeads.COUNT));
			} else {
				head.gotoAndStop(headtype);
			}
			
			if (headtype == ZombieHeads.BILLY) {
				body.gotoAndStop("BillyIdle");
			}
			
			immuneTime = 5;
			this.hurtSounds = new Array(new HurtOne());
		}
		
		private function Attack() {
			if (!attacking && stats.stamina > AbilityCosts.ATTACK && hasShotTimer <= 0) {
				stats.stamina -= AbilityCosts.ATTACK;
				attacking = true;
				
				if (GameManager.sean.getBounds(GameManager.gameScreen.roomLayer).x < x) {
						scaleX = -startScaleX;
					} else {
						scaleX = startScaleX;
					}
					
				if(head.currentFrame != ZombieHeads.BILLY) {
					body.gotoAndPlay("Attack");
				}  else {
					body.gotoAndPlay("BillyAttack");
				}
				
				if (weaponSlot.GetWeapon().weaponType != WeaponTypes.BOW && weaponSlot.GetWeapon().weaponType != WeaponTypes.SHOTGUN ) {
					body.addEventListener("CheckHit", CheckHit); 
				} else {
					
					weaponSlot.GetWeapon().PlaySound();
					weaponSlot.GetWeapon().Shoot(scaleX, this);
					hasShotTimer = 50;
				}
				addEventListener("AttackFinished", AttackFinished);
			}
		}
		
		private function CheckHit(e:Event) {
			var trans:SoundTransform = new SoundTransform(GameManager.soundLevel, 0);
			channel = new SlashOne().play(0, 0, trans);
			trans = null;
			channel = null;
			GameManager.gameScreen.GetRoom().AttackEntities(this, weaponSlot.GetWeapon());
			body.removeEventListener("CheckHit", CheckHit);
		}
		
		private function AttackFinished(e:Event) {
			removeEventListener("AttackFinished", AttackFinished);
			attacking = false;
			if(head.currentFrame != ZombieHeads.BILLY) {
				body.gotoAndStop("Idle");
			}  else {
				body.gotoAndStop("BillyIdle");
			}
		}
		
		private function Die() {
			if (currentLabel != "dying") {
				var trans:SoundTransform = new SoundTransform(GameManager.soundLevel, 0);
				channel = new DieSound().play(0, 0, trans);
				trans = null;
				channel = null;
				dispatchEvent(new Event("Killed"));
				addEventListener("dead", Kill);
				gotoAndPlay("dying");
				dead = true;
				
				if (item != null) {
					DropItem();
				}
			}
		} 
		
		public override function Update():void {
			super.Update();
			if (hasShotTimer > 0) {
				hasShotTimer--;
			}
			
			if(!dead) {
				if(stats.stamina < stats.maxStamina) {
						stats.stamina++;
				}
				
				var dist:Number = Math.floor(getDistance(GameManager.sean, this));
				healthbar.width = stats.health / stats.maxHealth * startWidthHealthBar;
				if ((dist < stats.vision && !knockedBack && (dist > GameManager.sean.width) && weaponSlot.GetWeapon().weaponType != WeaponTypes.BOW) || 
				(weaponSlot.GetWeapon().weaponType == WeaponTypes.BOW && (GameManager.sean.getBounds(stage).y - GameManager.sean.height / 3 < getBounds(stage).y - 150 || GameManager.sean.getBounds(stage).y + GameManager.sean.height / 3 > getBounds(stage).y + height))) {
					hasDestination = false;
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
					
				} else if (dist >= stats.vision){
					if ((randomRange(0, 100) == 1) && !hasDestination) {
						destX = x + randomRange(0, 200) - 100;
						destY = y + randomRange(0, 200) - 100;
						hasDestination = true;
					} else if (hasDestination) {
						
						if(!startedWalking) {
							legs.legs.gotoAndPlay("Walk");
							startedWalking = true;
						}
						dir = Math.atan2(destY - y, destX - x);
						oldX = x;
						oldY = y;
						xChange = Math.cos(dir) * stats.speed;
						yChange = Math.sin(dir) * stats.speed;
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
							hasDestination = false;
						}
						
						var distX:Number = destX - x;
						var distY:Number = destY - y;
						var dist2:Number = Math.sqrt(distX * distX + distY * distY);
						
						if (Math.floor(dist2) <= 10) {
							hasDestination = false;
						}
						
					} else {
						startedWalking = false;
						legs.legs.gotoAndStop("Idle");
					}
				} else if ((dist <= GameManager.sean.width + 30 || weaponSlot.GetWeapon().weaponType == WeaponTypes.BOW || weaponSlot.GetWeapon().weaponType == WeaponTypes.SHOTGUN) && !attacking) {
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