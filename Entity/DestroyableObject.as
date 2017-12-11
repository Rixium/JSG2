package Entity 
{
	
	import Constants.GameManager;
	import Constants.ZombieHeads;
	import Items.Drop;
	import Items.Food;
	import Sounds.HurtOne;
	import UIObjects.HealthBar;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import Weapons.Weapon;
	import Sounds.*;
	import flash.media.SoundTransform;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import Helpers.RandomRange;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class DestroyableObject extends EnemyBase 
	{
		
		public var destroyed:Boolean = false;
		
		public function DestroyableObject() 
		{
			super();
			
			if (RandomRange.randomRange(0, 10) < 5) {
				this.item = new Food();
			}
		}

		public function check() {
			if (destroyed) {
				parent.removeChild(this);
			}
		}
		
		protected function Die() {
			if (currentLabel != "dying") {
				destroyed = true;
				addEventListener("dead", Kill);
				gotoAndPlay("dying");
				dead = true;
				
				var trans:SoundTransform = new SoundTransform(GameManager.soundLevel, 0);
				var soundToPlay = randomRange(0, hurtSounds.length - 1);
				var hurtSound:Sound = new CrateBreak();
				channel = hurtSound.play(0, 0, trans);
				hurtSound = null;
				trans = null;
				
				if (item != null) {
					DropItem();
				}
			}
			
		}
		
		public function Remove() {
			parent.removeChild(this);
			destroyed = true;
		}
		
		public override function Update():void {
			if(!dead) {
				if (stats.health <= 0) {
					stats.health = 0;
					Die();
				}
			}
		}

	}

}