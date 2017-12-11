package Entity 
{
	/**
	 * ...
	 * @author Rixium
	 */
	
	 import Sounds.CrateBreak;
	 import flash.events.Event;
	 import flash.media.Sound;
	 import flash.media.SoundTransform;
	 import Constants.GameManager;
	 import Items.Food;
	 
	public class Bin extends DestroyableObject
	{
		
		public function Bin(x:int, y:int) 
		{
			super();
			displayName = "Bin";
			description = "Full of Deep Fried Chicken legs.";
			stats = new Stats(1, 1, 1);
			canKnockback = false;
			this.x = x;
			this.y = y;
			this.item = new Food();
		}
		
		private function FadeOut(e:Event) {
			if (this.alpha > 0) {
				alpha -= 0.1;
			} else {
				removeEventListener(Event.ENTER_FRAME, FadeOut);
				if (item != null) {
					DropItem();
				}
				parent.removeChild(this);
			}
		}
		override protected function Die() 
		{
			if (!destroyed) {
				var trans:SoundTransform = new SoundTransform(GameManager.soundLevel, 0);
				var soundToPlay = randomRange(0, hurtSounds.length - 1);
				var hurtSound:Sound = new CrateBreak();
				channel = hurtSound.play(0, 0, trans);
				hurtSound = null;
				trans = null;
				destroyed = true;
				addEventListener(Event.ENTER_FRAME, FadeOut);
			}
		}
	}

}