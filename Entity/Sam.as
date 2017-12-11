package Entity 
{
	import Rooms.Rooftop;
	import Sounds.HeavyBang;
	import UIObjects.BossHealthBar;
	import UIObjects.HealthBar;
	import fl.motion.Color;
	import flash.display.MovieClip;
	import Constants.GameManager;
	import Helpers.RandomRange;
	import flash.events.Event;
	import flash.utils.Timer;
	
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import Sounds.Sam.*;
	import Constants.RoomNames;
	
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class Sam extends EnemyBase
	{
		
		var attacking:Boolean = false;
		var currentAttack:int = 1;
		var canMove:Boolean = true;
		var canLook:Boolean = true;
		
		var startSpeed:int = 5;
		var speed:int;
		var voiceChannel:SoundChannel;
		var trans:SoundTransform = new SoundTransform(GameManager.soundLevel, 0);

		var pupilShoot:Color = new Color(1, 1, 1, 1, 0, 0, 0, 0);
		var attacking1:Boolean = false;
		var shootingLaser:Boolean = false;
		var attacking2:Boolean = false;
		var attacking3:Boolean = false;
		var endAttack3:Boolean = false;
		var multilier:Number = 0;
		var shootingBullets:Boolean = false;
		var red:int = 172;
		var blue:int = 50;
		var green:int = 50;
		var tintColor:uint;
		
		var laser:LaserBeam;
		var tentacle:Tentacle;
		var healthBar:BossHealthBar;
		var tentacleTargetX:int;
		var setTentacle:Boolean = false;
		var phase:int = 1;
		
		public var dying:Boolean = false;
		
		var bullets:Array = new Array();
		
		public function Sam() 
		{
			super();
			GameManager.sean.canKnockback = false;
			canKnockback = false;
			speed = startSpeed;
			displayName = "";
			description = "A gigantic eyeball.";
			var rHex:String = red.toString(16);
			var gHex:String = green.toString(16);
			var bHex:String = blue.toString(16);
			
			if (rHex.length == 1) {
				rHex = "0" + rHex;
			} 
			if (gHex.length == 1) {
				gHex = "0" + gHex;
			}
			if (bHex.length == 1) {
				bHex = "0" + bHex;
			}
			
			tintColor = uint("0x" + rHex + gHex + bHex);
			
			eBounds = pupil.getChildByName("bounds") as MovieClip;
			stats = new Stats(0, 1000, 500);
			xScale = scaleX;
			yScale = scaleY;
			
			
		}
		
		public function Destroy() {
			visible = false;
		}
		public function BossReady() {
			healthBar = new BossHealthBar(stats.maxHealth);
			GameManager.ui.addChild(healthBar);
			healthBar.y = 0;
			GameManager.gameScreen.GetRoom().SetBoss(this);
			healthBar.nameBar.text = "The Septic Eye";
		}
		
		private function LaserAttack() {
			if (phase != 2) {
				canMove = false;
			} else {
				speed = 2;
			}
			canLook = false;
			attacking1 = true;
			voiceChannel = new EyeCharge().play(0, 0, trans);
			voiceChannel.addEventListener(Event.SOUND_COMPLETE, ShootLaser);
		}
		
		private function EndLaserAttack(e:Event) {
			shootingLaser = false;
			voiceChannel.removeEventListener(Event.SOUND_COMPLETE, EndLaserAttack);
			attacking = false;
			canMove = true;
			canLook = true;
			attacking1 = false;
			speed = startSpeed;
			laser.Kill();
		}
		
		private function ShootLaser(e:Event) {
			voiceChannel.removeEventListener(Event.SOUND_COMPLETE, ShootLaser);
			laser = new LaserBeam();
			GameManager.gameScreen.GetRoom().frontLayer.addChild(laser);
			
			voiceChannel = new LaserSound().play(0, 0, trans);
			voiceChannel.addEventListener(Event.SOUND_COMPLETE, EndLaserAttack);
			red = 172;
			green = 50;
			blue = 50;

			shootingLaser = true;
			pupilShoot.setTint(tintColor, multilier);
			pupil.transform.colorTransform = pupilShoot;
			
			laser.x = x + 20;
			laser.y = y + 200;
		}
		
		private function LookAt(e:MovieClip) {
			if(canLook) {
				var dist_Y:Number = e.y - this.y ;
				var dist_X:Number = e.x -this.x ;
				var angle:Number = Math.atan2(dist_Y,dist_X);
				var degrees:Number = angle * 180 / Math.PI - 90;
				
				if (pupil.rotation < degrees) {
					pupil.rotation++;
				} else if (pupil.rotation > degrees) {
					pupil.rotation--;
				}
			} else {
				if (pupil.rotation > 0) {
					pupil.rotation--;
				} else {
					pupil.rotation++;
				}
			}
		}
		
		private function MoveTowards(e:EntityBase) {
			if (canMove) {
				if (e.x < x) {
					this.x -= speed;
				} else if (e.x > x) {
					this.x += speed;
				}
			}
		}
		
		private function ReadyTentacle() {
			if(!setTentacle) {
				tentacleTargetX = GameManager.sean.getBounds(GameManager.gameScreen.GetRoom()).x;
				var target:Targetter = new Targetter();
				target.x = tentacleTargetX;
				target.y = GameManager.sean.getBounds(GameManager.gameScreen.GetRoom()).y;
				GameManager.gameScreen.GetRoom().frontLayer.addChild(target);
				setTentacle = true;
				LookAt(target);
			}
		}
		
		private function SlamTentacle(e:Event) {
			attacking2 = false;
			gotoAndStop("Idle");
			scaleX = xScale;
			scaleY = yScale;
			voiceChannel.removeEventListener(Event.SOUND_COMPLETE, SlamTentacle);
			GameManager.gameScreen.GetRoom().Shake();
			voiceChannel = new HeavyBang().play(0, 0, trans);
			tentacle = new Tentacle(tentacleTargetX, 440);
			GameManager.gameScreen.GetRoom().DamageEntities(tentacle, 30, 0);
			GameManager.gameScreen.GetRoom().frontLayer.addChild(tentacle);
			var timerTime:int = 2000;
			
			if (phase == 2) {
				timerTime = 500;
			}
			var timer:Timer = new Timer(timerTime, 1);
			timer.addEventListener(TimerEvent.TIMER, EndTentacleAttack);
			timer.start();
		}
		
		private function EndTentacleAttack(e:TimerEvent) {
			GameManager.gameScreen.GetRoom().StopShake();
			attacking = false;
			canMove = true;
			setTentacle = false;
			attacking2 = false;
			tentacle.Kill();
		}
		
		private function TentacleAttack() {
			attacking = true;
			canMove = false;
			attacking2 = true;
			voiceChannel = new EyeCharge().play(0, 0, trans);
			gotoAndPlay("TentacleAttack");
			addEventListener("ReadyTentacle", ReadyTentacle);
			voiceChannel.addEventListener(Event.SOUND_COMPLETE, SlamTentacle);
		}
		
		private function BombAttack() {
			shootingBullets = true;
			innerTentacle.visible = false;
			attacking3 = true;
			if(phase == 1) {
				canMove = false;
			}
			voiceChannel = new SamLaugh().play(0, 0, trans);
			var stopShootTimer:Timer = new Timer(7000, 1);
			stopShootTimer.addEventListener(TimerEvent.TIMER, StopShooting);
			stopShootTimer.start();
			var timer:Timer = new Timer(11000, 1);
			timer.addEventListener(TimerEvent.TIMER, EndBombAttack);
			timer.start();
		}
		
		private function StopShooting(e:TimerEvent) {
			shootingBullets = false;
		}
		
		private function EndBombAttack(e:TimerEvent) {
			(GameManager.gameScreen.GetRoom() as Rooftop).bossLayer.addChild(this);
			endAttack3 = true;
			canMove = true;
		}
		
		public function End() {
			GameManager.ui.SetHealthBarPos(10);
			if (healthBar != null) {
				healthBar.visible = false;
				healthBar.Kill();
			}
		}
		
		private function Attack() {
			if (!attacking) {
				var shouldAttack:Boolean = RandomRange.randomRange(0, 200) <= 1;
				if (shouldAttack) {
					attacking = true;
					switch(currentAttack) {
						case 0:
							LaserAttack();
							break;
						case 1:
							TentacleAttack();
							break;
						case 2:
							BombAttack();
							break;
						default:
							break;
					}
					if(currentAttack < 2) {
						currentAttack++;
					} else {
						currentAttack = 0;
					}
				}
			}
			if (attacking1) {
				if (shootingLaser) {
						GameManager.sean.immune = false;
						GameManager.gameScreen.GetRoom().DamageEntities(laser, 1, 0);
						GameManager.sean.immune = false;
				}
				
				if (canMove) {
					if(laser != null) {
						laser.x = x + 20;
						laser.y = y + 200;
					}
				}
				if (multilier < 1) {
					multilier += 0.01;
				} else {
					multilier = 1;
				}
				pupilShoot.setTint(tintColor, multilier);
				pupil.transform.colorTransform = pupilShoot;
			} else {
				if (multilier > 0) {
					multilier -= 0.1;
				} else {
					multilier = 0;
				}
				pupilShoot.setTint(tintColor, multilier);
				pupil.transform.colorTransform = pupilShoot;
			}
			
			if (attacking2) {
				if (scaleX > xScale / 2) {
					scaleX -= 0.07;
				}
				if (scaleY > yScale / 2) {
					scaleY -= 0.07;
				}
				
				if (scaleX <= xScale / 2 && scaleY <= yScale / 2) {
					ReadyTentacle();
					GameManager.gameScreen.GetRoom().Shake();
				}
			}
			
			if (attacking3) {
				rotation += 10;
				if (scaleX > xScale / 2) {
					scaleX -= 0.07;
				}
				if (scaleY > yScale / 2) {
					scaleY -= 0.07;
				}
				
				if(shootingBullets) {
					if(scaleX <= xScale / 2 && scaleY <= yScale / 2) {
						if (rotation % 10 == 0) {
							var bullet:SepticBullet = new SepticBullet(x, y, rotation);
							GameManager.gameScreen.GetRoom().frontLayer.addChild(bullet);
							GameManager.gameScreen.GetRoom().frontLayer.addChild(this);
							bullets.push(bullet);
						}
					}
				}
			}
			
			if (endAttack3) {
				if (rotation > 0) {
					rotation -= 20;
				} else if (rotation < 0) {
					rotation += 20;
				}
				if (scaleX < xScale) {
					scaleX += 0.3;
				}
				if (scaleY < yScale) {
					scaleY += 0.3;
				}
				
				if (rotation > -21 && rotation < 21 && scaleX > xScale - 0.5 && scaleY > yScale - 0.5) {
					attacking3 = false;
					attacking = false;
					scaleX = xScale;
					scaleY = yScale;
					innerTentacle.visible = true;
					rotation = 0;
					endAttack3 = false;
				}
			}
			
			if (bullets.length > 0) {
				for (var i:int = 0; i < bullets.length; i++) {
					var b:SepticBullet = bullets[i] as SepticBullet;
					b.Update();
					
					if (GameManager.gameScreen.GetRoom().DamageEntities(b, 10, 0)) {
						b.canDie = true;
					}
					
					if (b.canDie) {
						b.Kill();
						bullets.removeAt(i);
					}
				}
			}
		}
		
		override public function Hit(e:EntityBase, power:int, knockback:int, dir:Number) 
		{
			super.Hit(e, power, knockback, dir);
			immune = false;
			
			
			if (stats.health <= 0 && !dying) {
				stats.health = 0;
				if(healthBar != null) {
					healthBar.Kill();
				}
				Die();
			}
			if(healthBar != null) {
				healthBar.Set(stats.health, stats.maxHealth);
			}
		}
		
		private function Die() {
				GameManager.ui.SetHealthBarPos(10);
				dying = true;
				gotoAndStop("Idle");
				attacking = false;
				attacking1 = false;
				attacking2 = false;
				attacking3 = false;
				endAttack3 = false;
		}
		
		public override function Update():void {
			if(!dying) {
				if(phase == 1) {
					if (stats.health < stats.maxHealth / 2) {
						phase = 2;
						speed *= 2;
					}
				}
				if(!setTentacle) {
					LookAt(GameManager.sean);
				}
				MoveTowards(GameManager.sean);
				Attack();
			} else {
				
			}
		}
		
	}

}