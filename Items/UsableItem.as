package Items 
{
	
	import Constants.ItemTypes;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import Sounds.*;
	import Constants.GameManager;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class UsableItem extends Item
	{
		
		protected var useSound:Sound;
		var trans:SoundTransform;
		
		
		public function UsableItem(image:int) 
		{
			super(image, ItemTypes.USABLE);
			trans = new SoundTransform(GameManager.soundLevel, 0); 
		}
		
		public function Use():Boolean {
			trans = new SoundTransform(GameManager.soundLevel, 0); 
			var channel:SoundChannel = useSound.play(0, 0, trans);
			channel = null;
			return true;
		}
		
	}

}