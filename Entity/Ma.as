package Entity 
{
	import flash.display.MovieClip;
	import Constants.GameManager;
	import UIObjects.HealthBar;
	import flash.display3D.textures.RectangleTexture;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import Weapons.Weapon;
	import Sounds.Ma.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class Ma extends EnemyBase
	{
		
		var startScaleX:Number;
		var startScaleY:Number;
		var headRef:MovieClip;
		var bodyRef:MovieClip;
		var legsRef:MovieClip;
		var startedWalking = false;
		var startWidthHealthBar:Number;
		var attacking:Boolean = false;
		var talking:Boolean = false;
		var voiceChannel:SoundChannel;
		var currentPhase = 1;
		var charging:Boolean = false;
		
		var attackTypes:Array = new Array("attack1", "charge");
		var chargeTimer:Timer = new Timer(2000, 0);
		
		var targetPosX:int;
		var targetPosY:int;
		var lastSpeed:int;
		var tempSpeed:int;
		var dirToGo:Number;
		
		var voiceSounds:Array = new Array(new MaOne(), new MaTwo(), new MaThree(), new MaFour(), new MaFive(), new  MaSix());
		
		public function Ma() 
		{
			super();
			headRef = (body.headHolder.head) as MovieClip;
			bodyRef = body;
			legsRef = legs;
			startScaleX = scaleX;
			startScaleY = scaleY;
			
			headRef.gotoAndStop("happy");
			
			stats = new Stats(5, 200, 100);
			stats.vision = 1400;

			displayName = "Ma";
			description = "A strange aura surrounds her.";
			startWidthHealthBar = healthbar.width;
			canKnockback = false;
			this.hurtSounds = new Array(new MaHurtOne(), new MaHurtTwo(), new MaHurtThree());
		}
		
		public override function Initialize() {
			super.Initialize();
			GameManager.gameScreen.GetRoom().AddEntity(this);
		}
		
		private function PlayVoice():void {
			if (!talking && !attacking) {
				talking = true;
				var trans:SoundTransform = new SoundTransform(GameManager.soundLevel, 0);
				var soundToPlay = randomRange(0, voiceSounds.length - 1);
				var sound:Sound = voiceSounds[soundToPlay] as Sound;
				voiceChannel = sound.play(0, 0, trans);
				voiceChannel.addEventListener(Event.SOUND_COMPLETE, SoundOver);
				sound = null;
				trans = null;
			}
		}
		
		private function SoundOver(e:Event) {
			talking = false;
			voiceChannel.stop();
			voiceChannel.removeEventListener(Event.SOUND_COMPLETE, SoundOver);
		}
		
		private function StartPhase2() {
			currentPhase = 2;
			stats.speed *= 2;
		}
		
		override public function Update():void 
		{
			if (!dead) {
				if (randomRange(0, 200) == 1) {
					PlayVoice();
				}
				
				if (stats.health == stats.maxHealth / 2 && currentPhase == 1) {
					StartPhase2();
				}
				
				if(stats.stamina < stats.maxStamina) {
						stats.stamina++;
				}
				
				var dist:Number = Math.floor(getDistance(GameManager.sean, this));
				healthbar.width = stats.health / stats.maxHealth * startWidthHealthBar;
				if (dist < stats.vision && !knockedBack && !attacking && !charging) {
					if(!startedWalking) {
						legsRef.gotoAndPlay("walk");
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
					legsRef.gotoAndStop("idle");
				} else if (charging) {
					if(!startedWalking) {
						legsRef.gotoAndPlay("walk");
						startedWalking = true;
					}
					oldX = x;
					oldY = y;
					xChange = -(Math.cos(dirToGo)) * stats.speed;
					yChange = -(Math.sin(dirToGo)) * stats.speed;
					if (xChange < 0) {
						scaleX = -startScaleX;
					} else {
						scaleX = startScaleX;
					}
					x +=  xChange;
					y +=  yChange;
					
					if(!GameManager.gameScreen.GetRoom().CheckAble(this, true)) {
						x = oldX;
						y = oldY;
						EndCharge(null);
					}
					
					eRect = null;
					entityRect = null;
					
				}
				
				if ((dist <= GameManager.sean.width - 5) && !attacking ) {
					startedWalking = false;
					Attack();
				} else if(!attacking && !charging){
					var shouldCharge:Boolean = (randomRange(0, 100) == 1);
					if (shouldCharge) {
						Charge();
					}
				}
				
				if (stats.health <= 0) {
					stats.health = 0;
					Die();
				}
			}
		}
		
		private function Charge() {
			charging = true;
			attacking = true;
			GameManager.gameScreen.GetRoom().Shake();
			var seanRect:Rectangle = GameManager.sean.eBounds.getBounds(stage);
			var entityRect:Rectangle = eBounds.getBounds(stage);
			dirToGo = Math.atan2((entityRect.y + entityRect.height) / 2 - (seanRect.y + seanRect.height) / 2, (entityRect.x + entityRect.width) / 2 - (seanRect.x + seanRect.width) / 2);
			startedWalking = false;
			bodyRef.gotoAndStop("charge");
			chargeTimer.reset();
			lastSpeed = stats.speed;
			stats.speed = 20;
			chargeTimer.addEventListener(TimerEvent.TIMER, EndCharge);
			chargeTimer.start();
		}
		
		private function EndCharge(e:TimerEvent) {
			GameManager.gameScreen.GetRoom().StopShake();
			stats.speed = lastSpeed;
			bodyRef.gotoAndStop("idle");
			//bodyRef.headHolder.head.gotoAndStop("angry");
			chargeTimer.reset();
			chargeTimer.removeEventListener(TimerEvent.TIMER, EndCharge);
			attacking = false;
			charging = false;
			startedWalking = false;
		}
		
		private function Die() {
			if (currentLabel != "dying") {
				bodyRef.gotoAndStop("idle");
				legsRef.gotoAndStop("idle");
				//addEventListener("dead", Kill);
				//gotoAndPlay("dying");
				dead = true;
			}
		}
		
		private function Attack() {
			if (!attacking && stats.stamina > AbilityCosts.ATTACK) {
				
				stats.stamina -= AbilityCosts.ATTACK;
				attacking = true;
				bodyRef.gotoAndPlay("attack1");	
				legsRef.gotoAndPlay("attack1");
				bodyRef.addEventListener("CheckHit", CheckHit); 
				bodyRef.addEventListener("attackFinished", AttackFinished);
			}
		}
		
		private function CheckHit(e:Event) {
				GameManager.gameScreen.GetRoom().AttackEntitiesNoWeapon(this, bodyRef.hitarea, 10, 40);
				body.removeEventListener("CheckHit", CheckHit);
				GameManager.gameScreen.GetRoom().Shake();
		}
		
		private function AttackFinished(e:Event) {
			bodyRef.removeEventListener("attackFinished", AttackFinished);
			bodyRef.gotoAndStop("idle");
			GameManager.gameScreen.GetRoom().StopShake();
			
			var shouldCharge:Boolean = (randomRange(0, 10) == 1);
			if (shouldCharge) {
				Charge();
			} else {
				attacking = false;
			}
		}
		
	}

}