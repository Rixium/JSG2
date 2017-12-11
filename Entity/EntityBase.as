package Entity
{
	
	import Sounds.*;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import Weapons.Weapon;
	import flash.display.MovieClip;
	import Constants.GameManager;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.utils.Timer;
	import flash.media.SoundTransform;
	import flash.media.SoundChannel;
	
	public class EntityBase extends MovieClip
	{
		
		protected var stats:Stats;
		public var description:String;
		public var displayName:String;
		protected var weaponSlot:WeaponSlot;
		public var immune:Boolean = false;
		public var eBounds:MovieClip;
		public var dead:Boolean;
		public var canKnockback = true;
		
		protected var knockedBack = false;
		protected var knockbackTimer:Timer;
		protected var knockbackPower = 0;
		protected var knockbackDir:Number = 0;
		protected var hurtSounds:Array = [];
		var channel:SoundChannel
		var startColor:ColorTransform;
		var immuneTime:int = 30;
		var immuneTimer:int;
		
		public var xScale:Number;
		public var yScale:Number;

		public function EntityBase()
		{
			xScale = 1;
			yScale = 1;
			if(getChildByName("bounds") != null) {
				eBounds = getChildByName("bounds") as MovieClip;
			}
		}
		
		public function GetHitBounds():MovieClip {
			return getChildByName("mouseOverBounds") as MovieClip;
		}
		
		public function Initialize() {
			var mouseOverBounds:MovieClip = getChildByName("mouseOverBounds") as MovieClip;
			startColor = transform.colorTransform;
			
			mouseOverBounds.addEventListener(MouseEvent.MOUSE_OVER, MouseOver);
			mouseOverBounds.addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
			
			mouseOverBounds = null;
		}

		public function MouseOver(e:MouseEvent):void {
			GameManager.mouseInfo.SetText(displayName);
			GameManager.ui.SetDescriptor(description, false);
		}
		
		public function MouseOut(e:MouseEvent):void {
			GameManager.mouseInfo.SetText("");
			GameManager.ui.SetDescriptor("", true);
		}
		
		public function GetStats():Stats {
			return stats;
		}
		
		public function Update():void {
			if (immuneTimer > 0) {
				immuneTimer--;
			} else if (immuneTimer <= 0) {
				immune = false;
			}
		}
		
		protected function Kill(e:Event):void {
			Cleanup();
		}
		
		public function Cleanup() {
			removeEventListener("dead", Kill);
			parent.removeChild(this);
		}
		
		protected function getDistance(e1:EntityBase, e2:EntityBase):Number {
			var rect1:Rectangle = e1.eBounds.getBounds(stage);
			var rect2:Rectangle = e2.eBounds.getBounds(stage);
			
			var distX:Number = (rect1.x + rect1.width / 2) - (rect2.x + rect2.width / 2);
			var distY:Number = (rect1.y + rect1.height / 2) - (rect2.y + rect2.height / 2);
			return Math.sqrt(distX * distX + distY * distY);
		}
		
		public function Hit(e:EntityBase, power:int, knockback:int, dir:Number) {
			stats.vision = 1000;
			if(!immune) {
				if (!knockedBack && canKnockback) {
					knockedBack = true;
					knockbackPower = power;
					knockbackTimer = new Timer(2, knockback + (knockbackPower / 2));
					knockbackDir = dir;
					var newColorTrans:ColorTransform = transform.colorTransform;
					newColorTrans.redOffset = 255 * 0.5;
					transform.colorTransform = newColorTrans;
					knockbackTimer.addEventListener(TimerEvent.TIMER, Knockback);
					knockbackTimer.addEventListener(TimerEvent.TIMER_COMPLETE, KnockbackFinished);
					knockbackTimer.reset();
					knockbackTimer.start();
				}
				
				if(immuneTimer == 0) {
					if(hurtSounds.length > 0) {
						var trans:SoundTransform = new SoundTransform(GameManager.soundLevel, 0);
						var soundToPlay = randomRange(0, hurtSounds.length - 1);
						var hurtSound:Sound = hurtSounds[soundToPlay] as Sound;
						channel = hurtSound.play(0, 0, trans);
						hurtSound = null;
						trans = null;
					}
				}
				this.stats.health -= power;
				immune = true;
				immuneTimer = immuneTime;
			}
		}
		
		protected function randomRange(minNum:Number, maxNum:Number):Number 
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		private function KnockbackFinished(e:TimerEvent) {
			knockedBack = false;
			transform.colorTransform = startColor;
			knockbackTimer.removeEventListener(TimerEvent.TIMER, Knockback);
			knockbackTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, KnockbackFinished);
			knockbackTimer = null;
		}
		
		private function Knockback(e:TimerEvent) {
			var oldX = x;
			var oldY = y;
			
			x +=  -(Math.cos(knockbackDir) * knockbackPower + knockbackPower / 2);
			y +=  -(Math.sin(knockbackDir) * knockbackPower + knockbackPower / 2);
			if (!GameManager.gameScreen.GetRoom().CheckAble(this, false)) {
				x = oldX;
				y = oldY;
			}
			
		}
		
		public function GetWeapon():Weapon {
			if (weaponSlot.GetWeapon() != null) {
				return weaponSlot.GetWeapon();
			} else {
				return null;
			}
		}
		
	}
}